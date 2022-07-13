import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
            lightTheme: const SettingsThemeData(settingsListBackground: Color.fromRGBO(180, 136, 212, 1),),
            darkTheme: const SettingsThemeData(settingsListBackground: Color.fromRGBO(180, 136, 212, 1),),
            sections: [
              SettingsSection(
                title: Text('General', style: TextStyle(color: Colors.black),),
                tiles: <SettingsTile>[
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.notifications_none, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('Turn ON/OFF BTS related notifications', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Btw I rarely send those  >.<", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.question_mark, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('FAQ', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Got stuck somewhere? This might help you", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.bug_report_outlined, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('Found a Bug? Suggestions?', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Feel free to give your inputs as it helps a lot!", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.notes, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('Version Notes', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Check out upcoming features and previous version notes", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.code, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('Source Code', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Get to see all the coding work here", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.share, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('Share', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Share to other armys as well  ~.~", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.star_rate_outlined, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('Rate on Google Play', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Thankuu in advance :') Borahae 💜", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.favorite_outline, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('Credits', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Special thanks to translator armys and genius.com", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),
                  SettingsTile(
                    onPressed: (context) {},
                    leading: Icon(Icons.apps, color: Color.fromRGBO(91, 50, 120, 1),),
                    title: Text('App info', style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
                    description: Text("Some extra stuff", style: GoogleFonts.openSans(color: Colors.black87)),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
