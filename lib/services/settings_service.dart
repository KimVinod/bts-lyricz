import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:bts_lyricz/utils/widgets/settings_card.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:native_updater/native_updater.dart';

class SettingsService {

  static Future _saveMaterialYou(bool isMaterialYou) async {
    Box materialYouBox = await Hive.openBox('materialYouBox');
    materialYouBox.put('isMaterialYou', isMaterialYou);
  }

  static Future<bool> loadMaterialYou() async {
    Box materialYouBox = await Hive.openBox('materialYouBox');
    return materialYouBox.get('isMaterialYou', defaultValue: false);
  }

  static Future<String> _getTheme() async {
    Box userThemeBox = await Hive.openBox('userTheme');
    return userThemeBox.get('theme',defaultValue: 'light'); // light, dark, system
  }

  static Future _saveTheme(String theme) async {
    Box userThemeBox = await Hive.openBox('userTheme');
    userThemeBox.put('theme', theme);
  }

  static Future<ThemeMode> loadTheme() async {
    String userTheme = await _getTheme();
    if(userTheme == "light") {
      return ThemeMode.light;
    } else if(userTheme == "dark") {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }


  static Future<void> openThemeDialog(BuildContext context) async {
    bool isMaterialYou = await loadMaterialYou();

    onChanged(String theme) {
      _saveTheme(theme).then((value) async {
        if(context.mounted) {
          Navigator.pop(context);
          BTSLyricsApp.of(context).changeTheme(await loadTheme());
        }
      });
    }

    await _getTheme().then((value) async {

        final deviceInfoPlugin = DeviceInfoPlugin();
        final deviceInfo = await deviceInfoPlugin.androidInfo; //IMPLEMENTED ONLY FOR ANDROID.
        if(deviceInfo.version.sdkInt < 31) isMaterialYou = false;
        if(context.mounted) {
          showDialog(context: context, builder: (context) => StatefulBuilder(
              builder: (context, setState) {

                onChangedMaterialYou(bool newIsMaterialYou) {
                  _saveMaterialYou(newIsMaterialYou).then((value) async {
                    setState(() => isMaterialYou = newIsMaterialYou);
                    if(context.mounted) BTSLyricsApp.of(context).changeMaterialYou(await loadMaterialYou());
                  });
                }

                return AlertDialog(
                  title: const Text("Set app theme"),
                  contentPadding: const EdgeInsets.only(top: 16),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(deviceInfo.version.sdkInt >= 31 && Platform.isAndroid)...[
                        SwitchListTile(
                          value: isMaterialYou,
                          contentPadding: const EdgeInsets.fromLTRB(28, 0, 16, 8),
                          title: const Text("Google Material You"),
                          subtitle: const Text("Uses your wallpaper to identify source color"),
                          onChanged: (value) => onChangedMaterialYou(value),
                          inactiveTrackColor: Theme.of(context).colorScheme.surfaceContainer,
                          inactiveThumbColor: Theme.of(context).colorScheme.tertiary,
                          trackOutlineColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
                        ),
                      ],
                      RadioListTile<String>(
                        value: 'light',
                        groupValue: value,
                        title: Text(isMaterialYou ? "Light" : "Bora"),
                        onChanged: (value) => onChanged(value!),
                      ),
                      RadioListTile<String>(
                        value: 'dark',
                        groupValue: value,
                        title: const Text("Dark"),
                        onChanged: (value) => onChanged(value!),
                      ),
                      RadioListTile<String>(
                        value: 'system',
                        groupValue: value,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),),
                        onChanged: (value) => onChanged(value!),
                        title: const Text("System default"),
                      ),
                    ],
                  ),
                );
              }
          ));
        }
    });
  }

  static Future<String> loadGameLanguage() async {
    Box userGameBox = await Hive.openBox('userGame');
    return userGameBox.get('language', defaultValue: 'eng');
  }

  static Future<int> loadGameScore(String languageMode) async {
    Box userGameBox = await Hive.openBox('userGame');
    return userGameBox.get('highScore-$languageMode', defaultValue: 0);
  }

  static Future saveGameLanguage(String language) async {
    Box userGameBox = await Hive.openBox('userGame');
    userGameBox.put('language', language);
  }

  static Future saveGameScore(int highScore, String languageMode) async {
    Box userGameBox = await Hive.openBox('userGame');
    userGameBox.put('highScore-$languageMode', highScore);
  }

  static Future clearGameScore() async {
    Box userGameBox = await Hive.openBox('userGame');
    userGameBox.delete('highScore');
  }

  static Future<void> openGameLanguageDialog(BuildContext context, Function onDialogClosed) async {

    void onChanged(String lang) {
      saveGameLanguage(lang).then((value) {
        if(context.mounted) {
          Navigator.pop(context);
          onDialogClosed(true);
        }
      });
    }

    await loadGameLanguage().then((value) {
      if(context.mounted) {
        showDialog(context: context, builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text("Set language mode"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding: const EdgeInsets.only(top: 16),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<String>(
                      value: 'eng',
                      groupValue: value,
                      title: Text("English", style: GoogleFonts.openSans()),
                      onChanged: (value) => onChanged(value!),
                    ),
                    RadioListTile<String>(
                      value: 'kor',
                      groupValue: value,
                      title: Text("Korean", style: GoogleFonts.openSans()),
                      onChanged: (value) => onChanged(value!),
                    ),
                    RadioListTile<String>(
                      value: 'jp',
                      groupValue: value,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),),
                      title: Text("Japanese", style: GoogleFonts.openSans()),
                      onChanged: (value) => onChanged(value!),
                    ),
                  ],
                ),
              );
            }
        ));
      }
    });
  }

  static void _showShareLyricsWalkthrough(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Quick Guide", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),

                SettingsCard(icon: Icons.format_color_text, title: "Text color", subtitle: "Tap to switch between black or white lyrics.", onTap: null),
                SettingsCard(icon: Icons.crop_free_rounded, title: "Story mode", subtitle: "Perfect for full-screen Instagram stories.\nTurn OFF to share as a sticker.", onTap: null),
                SettingsCard(icon: Icons.verified_outlined, title: "App logo", subtitle: "Show or hide the app logo.", onTap: null),
                SettingsCard(icon: Icons.zoom_out_map, title: "Resize card", subtitle: "Pinch to resize the card.\nAvailable in story mode only.", onTap: null),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      onPressed: () async {
                        Navigator.pop(ctx);
                        Box userPrefsBox = await Hive.openBox('userPrefs');
                        userPrefsBox.put('showShareLyricsWalkthrough', false);
                      },
                      child: const Text("Don't show again", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> openShareLyricsWalkthrough(BuildContext context) async {
    Box userPrefsBox = await Hive.openBox('userPrefs');
    if(userPrefsBox.get('showShareLyricsWalkthrough', defaultValue: true) && context.mounted) {
      _showShareLyricsWalkthrough(context);
    }
  }

  static void openNotifications() => AppSettings.openAppSettings(type: AppSettingsType.notification);

  static void openBatteryOptimization() => AppSettings.openAppSettings(type: AppSettingsType.batteryOptimization);

  static void checkForUpdates(BuildContext context) {
    Fluttertoast.showToast(msg: "Checking for updates...", toastLength: Toast.LENGTH_SHORT);
    NativeUpdater.displayUpdateAlert(context, forceUpdate: true);
  }

  static void openVersionNotes() async {
    if(await canLaunchUrlString(versionNotesUrl)) {
      launchUrlString(versionNotesUrl, mode: LaunchMode.platformDefault);
    } else {
      showToastError();
    }
  }

  static void openBTSGuide() async {
    if(await canLaunchUrlString(btsGuideUrl)) {
      launchUrlString(btsGuideUrl, mode: LaunchMode.platformDefault);
    } else {
      showToastError();
    }
  }

  static void _emailMe({required PackageInfo packageInfo}) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': '[${packageInfo.appName}] [Bug] [v${packageInfo.version}]'
      }),
    );
    if(await canLaunchUrlString(emailLaunchUri.toString())) {
      launchUrlString(emailLaunchUri.toString(), mode: LaunchMode.externalApplication);
    } else {
      showToastError();
    }
  }

  static void _twitter() async {
    if(await canLaunchUrlString(twitterUrl)) {
      launchUrlString(twitterUrl, mode: LaunchMode.externalApplication);
    } else {
      showToastError();
    }
  }

  static void playSong(String url) async {
    if(await canLaunchUrlString(url)) {
      launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      showToastError();
    }
  }

  static Future<PackageInfo> _getPackageInfo() async => await PackageInfo.fromPlatform();

  static Future<void> showFoundBugDialog({required BuildContext context}) async {

    final PackageInfo packageInfo = await _getPackageInfo();
    if(context.mounted) {
      showDialog(context: context, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28)),),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              onTap: () {
                Navigator.pop(context);
                _emailMe(packageInfo: packageInfo);
              },
              title: Text("Email me", style: GoogleFonts.openSans()),
            ),
            ListTile(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              onTap: () {
                Navigator.pop(context);
                _twitter();
              },
              title: Text("DM me on Twitter", style: GoogleFonts.openSans()),
            ),
          ],
        ),
      );
    });
    }
  }

  static void rateMe() async {
    if(await canLaunchUrlString(playStoreUrl)) {
      launchUrlString(playStoreUrl, mode: LaunchMode.externalApplication);
    } else {
      showToastError();
    }
  }

  static void share() => SharePlus.instance.share(ShareParams(text: shareText));

  static void showSourceCode() async {
    if(await canLaunchUrlString(githubUrl)) {
      launchUrlString(githubUrl, mode: LaunchMode.platformDefault);
    } else {
      showToastError();
    }
  }

  static Future<void> showAppInfo({required BuildContext context}) async {

    final PackageInfo packageInfo = await _getPackageInfo();
    if(context.mounted) {
      showDialog(
      context: context,
      builder: (BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: MediaQuery.sizeOf(context).width * 0.75,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bangtan Lyricz",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 19
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage("images/app-icon-v3.png")),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Text(
                    "Version: ${packageInfo.version} (${packageInfo.buildNumber})",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
              Text(
                "Special thanks to translator armys & genius.com for the lyrics :)",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontStyle: FontStyle.italic,
                    fontSize: 14
                ),
              ),
              Text(
                "Made by ARMY\nMade for ARMY\nMade with borahae 💜",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13
                ),
              ),
            ],
          ),
        ),
      ),
    );
    }
  }

  static Future<bool> checkOSDeprecation() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo; //IMPLEMENTED ONLY FOR ANDROID.
      return deviceInfo.version.sdkInt < 23;
    } catch(e) {
      return false;
    }
  }
}