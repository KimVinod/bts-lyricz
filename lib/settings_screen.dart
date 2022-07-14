import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Divider div = Divider(height: 0, thickness: 1, color: Color.fromRGBO(91, 50, 120, 1).withOpacity(0.3));

  void showDialogBox() {
    showDialog(context: context, builder: (context) {
      return Dialog(
        backgroundColor: Color.fromRGBO(180, 136, 212, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {},
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
                     description: Text("Btw I rarely send those  >.<", style: GoogleFonts.openSans(color: Colors.black87)),
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
                       showDialogBox();
                     },
                     leading: Icon(Icons.bug_report_outlined, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Found a Bug? Suggestions?', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Feel free to give your inputs as it helps a lot!", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {},
                     leading: Icon(Icons.notes, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Version Notes', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Check out upcoming features and previous version notes", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {},
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
                     description: Text("Share to other armys as well  ~.~", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {},
                     leading: Icon(Icons.star_rate_outlined, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Rate on Google Play', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Thankuuu in advance :') Borahae 💜", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {},
                     leading: Icon(Icons.favorite_outline, color: Color.fromRGBO(91, 50, 120, 1),),
                     title: Text('Credits', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                     description: Text("Special thanks to translator armys and genius.com", style: GoogleFonts.openSans(color: Colors.black87)),
                   ),
                   div,
                   SettingsTile(
                     onPressed: (context) {},
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
