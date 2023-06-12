import 'package:bts_lyrics_app/screens/home/home_screen.dart';
import 'package:bts_lyrics_app/services/firebase_service.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FirebaseService.setup();
  runApp(const BTSLyricsApp());
}

class BTSLyricsApp extends StatefulWidget {
  const BTSLyricsApp({super.key});

  @override
  State<BTSLyricsApp> createState() => _BTSLyricsAppState();
}

class _BTSLyricsAppState extends State<BTSLyricsApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseService.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        primaryColor: appUILightColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: appUILightColor),
      ),
      home: const HomeScreen(),
    );
  }
}
