import 'package:app_settings/app_settings.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:native_updater/native_updater.dart';

class SettingsService {
  static void openNotifications() => AppSettings.openNotificationSettings();

  static void openBatteryOptimization() => AppSettings.openBatteryOptimizationSettings();

  static void checkForUpdates(BuildContext context) => NativeUpdater.displayUpdateAlert(context, forceUpdate: true);

  static void openVersionNotes() async {
    if(await canLaunchUrlString(versionNotesUrl)) {
      launchUrlString(versionNotesUrl, mode: LaunchMode.inAppWebView);
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

  static Future<PackageInfo> _getPackageInfo() async => await PackageInfo.fromPlatform();

  static Future<void> showFoundBugDialog({required BuildContext context}) async {

    final PackageInfo packageInfo = await _getPackageInfo();
    if(context.mounted) {
      showDialog(context: context, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: appUILightColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28)),),
              contentPadding: EdgeInsets.symmetric(horizontal: 24),
              onTap: () {
                Navigator.pop(context);
                _emailMe(packageInfo: packageInfo);
              },
              title: Text("Email me", style: GoogleFonts.openSans(color: Colors.black)),
            ),
            Divider(height: 0, thickness: 1, color: appUIDarkColor.withOpacity(0.3)),
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),),
              contentPadding: EdgeInsets.symmetric(horizontal: 24),
              onTap: () {
                Navigator.pop(context);
                _twitter();
              },
              title: Text("DM me on Twitter", style: GoogleFonts.openSans(color: Colors.black)),
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

  static void share() => Share.share(shareText);

  static void showSourceCode() async {
    if(await canLaunchUrlString(githubUrl)) {
      launchUrlString(githubUrl, mode: LaunchMode.externalApplication);
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
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: appUILightColor,
            borderRadius:
            BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bangtan Lyricz",
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 19
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage("images/app-icon-new2.png")),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Text(
                    "Version: ${packageInfo.version} (${packageInfo.buildNumber})",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
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
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    //fontWeight: FontWeight.w600,
                    fontSize: 14
                ),
              ),
              Text(
                "Made by ARMY\nMade for ARMY\nMade with borahae 💜",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    color: Colors.black,
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
}