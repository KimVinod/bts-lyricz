import 'package:bts_lyricz/screens/home/home_screen.dart';
import 'package:bts_lyricz/services/firebase_service.dart';
import 'package:bts_lyricz/services/settings_service.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FirebaseService.setup(isRelease: true);
  runApp(BTSLyricsApp(themeMode: await SettingsService.loadTheme(), isMaterialYou: await SettingsService.loadMaterialYou()));
}

class BTSLyricsApp extends StatefulWidget {
  final ThemeMode themeMode;
  final bool isMaterialYou;
  const BTSLyricsApp({super.key, required this.themeMode, required this.isMaterialYou});

  @override
  State<BTSLyricsApp> createState() => BTSLyricsAppState();

  static BTSLyricsAppState of(BuildContext context) => context.findAncestorStateOfType<BTSLyricsAppState>()!;
}

class BTSLyricsAppState extends State<BTSLyricsApp> {
  late ThemeMode _themeMode;
  late bool isMaterialYou;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTheme();
    FirebaseService.init();
  }

  void _initTheme() {
    _themeMode = widget.themeMode;
    isMaterialYou = widget.isMaterialYou;
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void changeMaterialYou(bool isMaterialYou) {
    setState(() {
      this.isMaterialYou = isMaterialYou;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          ColorScheme? lightScheme, darkScheme;

          if (lightDynamic != null && darkDynamic != null) (lightScheme, darkScheme) = generateDynamicColourSchemes(lightDynamic, darkDynamic);

          return MaterialApp(
              theme: getLightTheme(isMaterialYou: isMaterialYou, lightColorScheme: lightScheme),
              darkTheme: getDarkTheme(isMaterialYou: isMaterialYou, darkColorScheme: darkScheme),
              themeMode: _themeMode,
              home: const HomeScreen()
          );
        }
    );
  }
}