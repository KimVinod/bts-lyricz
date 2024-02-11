import 'package:bts_lyrics_app/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Divider div = Divider(height: 25, thickness: 1, color: Theme.of(context).cardColor.withOpacity(0.7));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("FAQ", style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('1.\nWant to know a little about me?\nI\'m an army just like you :) BTS my loml is the only reason why I made this app <3',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('2.\nI won\'t add mp3 songs because of few reasons:\n\n'
                  '- App might get taken down because of copyright.\n\n'
                  '- There would be server costs for hosting songs on cloud, i.e: uploads/downloads. (I\'m a student haha)\n\n'
                  '- I believe we should listen songs only from official platforms (YT, Spotify, etc) to support our BTS through streams :)',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('3.\nSongs released before debut are currently not listed.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('4.\nSongs which does not have lyrics are not listed.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('5.\nNo cover songs.\nI think only bts-made songs and collabs where they get credited should be included.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('6.\nUnofficial songs sung by two or more members are listed under:\nDiscography -> Unofficial Songs.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            div,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('7.\nNotifications not working?\n'
                  'Your phone can restrict notifications to extend battery life.\n'
                  'Try doing these following steps:\n'
                  '- Enable auto-start from phone settings.',
                style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('- Disable battery optimization. ',style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500),),
                  GestureDetector(
                    onTap: () => SettingsService.openBatteryOptimization(),
                    child: Container(
                      color: Colors.transparent,
                      child: Text('Click here', style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
