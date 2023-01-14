import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Divider div = Divider(height: 25, thickness: 1, color: appUIDarkColor.withOpacity(0.3));

    return Scaffold(
      backgroundColor: appUILightColor,
      appBar: AppBar(
        title: Text("FAQ", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        titleSpacing: 0,
        backgroundColor: appBarColor,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('1.\nUnofficial songs sung by two or more members are listed under:\nDiscography -> Unofficial Songs.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('2.\nSongs released before debut are currently not listed.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('3.\nSongs which does not have lyrics are not listed.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('4.\nCover songs are not listed.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('5.\nI won\'t upload offline songs because of few reasons:\n'
                  '- Might get copyright claim.\n'
                  '- This will increase app size drastically.\n'
                  '- We should listen songs through official platforms to support our boys :)',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('6.\nNotifications not working?\n'
                  'Your phone can restrict notifications to extend battery life.\n'
                  'Try doing these following steps:\n'
                  '- Enable auto-start from phone settings.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text('- Disable battery optimization ',style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
                  GestureDetector(onTap: () => AppSettings.openBatteryOptimizationSettings(),child: Container(color: Colors.transparent, child: Text('Click here',style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold),))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
