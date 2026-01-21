import 'package:bts_lyricz/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeprecatedScreen extends StatelessWidget {
  const DeprecatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Unsupported OS", style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 30,
              children: [
                Text("This was a very tough decision. I'm really sorry but devices running on Android Lollipop 5.0 and 5.1 won't receive future updates.\n\n"
                  "This app is developed using Flutter, and they stopped supporting these on August 2025. This is a normal practice in the IT industry every year to stop supporting older versions.\n""Reason: More focus towards newer technologies, better security and support, etc.\n\n"
                  "I'll continue supporting these devices till end of 2026 (hopefully).\n\n"
                  "What can you do?\n"
                  "Check Android OS updates for your device.\n"
                  "Devices running Android 6.0 and newer are supported.",
                  style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text("Once again, I'm really sorry :'(")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
