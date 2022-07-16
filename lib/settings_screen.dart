import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Divider div = Divider(height: 0, thickness: 1, color: Color.fromRGBO(91, 50, 120, 1).withOpacity(0.3));

  void emailMe() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'vinoddevendran34@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': '[${_packageInfo.appName}] [Bug] [v${_packageInfo.version}]'
      }),
    );
    if(await canLaunchUrlString(emailLaunchUri.toString()))
      launchUrlString(emailLaunchUri.toString(), mode: LaunchMode.externalApplication);
    else {
      Fluttertoast.showToast(
        msg: "Error occurred. Your phone doesn't support opening links",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void showDialogBox(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return Dialog(
        backgroundColor: Color.fromRGBO(180, 136, 212, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                emailMe();
              },
              title: Text("Email me", style: TextStyle(color: Colors.black)),
            ),
            div,
            ListTile(
              onTap: () {},
              title: Text("DM me on Twitter", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );
    });
  }

  void showMore(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(
        child: Container(
          padding: EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: Color.fromRGBO(180, 136, 212, 1),
            borderRadius:
            BorderRadius.circular(20),
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
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/app-icon-new2.png")),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    Text(
                      "Version: ${_packageInfo.version} (${_packageInfo.buildNumber})",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
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

  void showSourceCode() async {
    final String url = "https://github.com/KimVinod/bts-lyricz";
    if(await canLaunchUrlString(url))
      launchUrlString(url, mode: LaunchMode.externalApplication);
    else {
      Fluttertoast.showToast(
        msg: "Error occurred. Your phone doesn't support opening links",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void rateMe() async {
    final String url = "https://play.google.com/store/apps/details?id=com.kimvinod.bts_lyricz";
    if(await canLaunchUrlString(url))
      launchUrlString(url, mode: LaunchMode.externalApplication);
    else {
      Fluttertoast.showToast(
        msg: "Error occurred. Your phone doesn't support opening links",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void versionNotes() async {
    final String url = "https://sites.google.com/view/bts-lyricz-ver";
    if(await canLaunchUrlString(url))
      launchUrlString(url);
    else {
      Fluttertoast.showToast(
        msg: "Error occurred. Your phone doesn't support opening links",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    //get package details
    _initPackageInfo();
  }

  Future<Null> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(180, 136, 212, 1),
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: Color.fromRGBO(150, 86, 190, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SettingsList(
            physics: BouncingScrollPhysics(),
            brightness: Brightness.light,
            contentPadding: EdgeInsets.zero,
            lightTheme: const SettingsThemeData(tileHighlightColor: Color.fromRGBO(150, 86, 190, 1), settingsListBackground: Color.fromRGBO(180, 136, 212, 1),),
            darkTheme: const SettingsThemeData(settingsListBackground: Color.fromRGBO(180, 136, 212, 1),),
            sections: [
             CustomSettingsSection(
               child: Column(
                 children: [
                   SettingsTile(
                     onPressed: (context) {
                       AppSettings.openNotificationSettings();
                     },
                     leading: Icon(Icons.notifications_none, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Turn ON/OFF BTS related notifications', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Btw I rarely send these  ~.~", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {},
                     leading: Icon(Icons.question_mark, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('FAQ', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Got stuck somewhere? This might help you", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {
                       versionNotes();
                     },
                     leading: Icon(Icons.notes, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Version Notes', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Check out upcoming features and previous version notes", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {
                       showDialogBox(context);
                     },
                     leading: Icon(Icons.bug_report_outlined, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Found a Bug? Suggestions?', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Feel free to give your inputs as it helps a lot!", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {
                       showSourceCode();
                     },
                     leading: Icon(Icons.code, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Source Code', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Get to see all the coding work here", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {
                       Share.share("Hey! Check this out. Get all the song lyrics of BTS in one place.\n\nApp name: Bangtan Lyricz\n\nGoogle Play Store:\nhttps://play.google.com/store/apps/details?id=com.kimvinod.bts_lyricz");
                     },
                     leading: Icon(Icons.share, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Share', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Share to other armys as well  >.<", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {
                       rateMe();
                     },
                     leading: Icon(Icons.star_rate_outlined, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Rate on Google Play', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Thankuuu in advance :')", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {
                       showMore(context);
                     },
                     leading: Icon(Icons.apps, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('App info', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Some extra stuff", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                 ],
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
