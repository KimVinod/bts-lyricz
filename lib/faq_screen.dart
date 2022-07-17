import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Divider div = Divider(height: 25, thickness: 1, color: Color.fromRGBO(91, 50, 120, 1).withOpacity(0.3));

    return Scaffold(
      backgroundColor: Color.fromRGBO(180, 136, 212, 1),
      appBar: AppBar(
        title: Text("FAQ", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        backgroundColor: Color.fromRGBO(150, 86, 190, 1),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          physics: BouncingScrollPhysics(),
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
              child: Text('4.\nNotifications not working?\n'
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
