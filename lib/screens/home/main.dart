import 'package:bts_lyrics_app/screens/home/home_screen.dart';
import 'package:bts_lyrics_app/services/firebase_service.dart';
import 'package:bts_lyrics_app/services/settings_service.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FirebaseService.setup();
  runApp(BTSLyricsApp(themeMode: await SettingsService.loadTheme()));
}

class BTSLyricsApp extends StatefulWidget {
  final ThemeMode themeMode;
  const BTSLyricsApp({super.key, required this.themeMode});

  @override
  State<BTSLyricsApp> createState() => BTSLyricsAppState();

  static BTSLyricsAppState of(BuildContext context) => context.findAncestorStateOfType<BTSLyricsAppState>()!;
}

class BTSLyricsAppState extends State<BTSLyricsApp> {
  ThemeMode? _themeMode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTheme();
    FirebaseService.init();
  }

  void _initTheme() {
    setState(() {
      _themeMode = widget.themeMode;
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll){
            overScroll.disallowIndicator();
            return true;
          },
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
