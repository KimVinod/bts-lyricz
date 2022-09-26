import 'package:bts_lyrics_app/firebase_options.dart';
import 'package:bts_lyrics_app/screens/home/home_screen.dart';
import 'package:bts_lyrics_app/screens/settings/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import 'package:bts_lyrics_app/screens/search/search_songs.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_updater/native_updater.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:bts_lyrics_app/screens/favorites/favorites_screen.dart';

final ZoomDrawerController z = ZoomDrawerController();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel", //id
  "BTS Related Notification Channel", //title
  importance: Importance.high,
  playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  //print("A BG msg just showed up: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  if(kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    FirebaseCrashlytics.instance.deleteUnsentReports();
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  runApp(MaterialApp(
      home: const BTSLyrics(),
    theme: ThemeData(
      textTheme: GoogleFonts.openSansTextTheme(),
      primaryColor: appUILightColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: appUILightColor)
    ),
  ));
}

class BTSLyrics extends StatefulWidget {
  const BTSLyrics({Key? key}) : super(key: key);


  @override
  BTSLyricsState createState() => BTSLyricsState();
}

class BTSLyricsState extends State<BTSLyrics> {

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //print("FG");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
             channel.id,
             channel.name,
             playSound: true,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print('A new onMessageOpenedApp event was published!');
    });

  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: ZoomDrawer(
        controller: z,
        menuScreenWidth: MediaQuery.of(context).size.width,
        borderRadius: 24,
        style: DrawerStyle.defaultStyle,
        showShadow: false,
        slideWidth: MediaQuery.of(context).size.width * 0.8,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
        angle: 0.0,
        mainScreenTapClose: true,
        mainScreenAbsorbPointer: true,
        disableDragGesture: false,
        androidCloseOnBackTap: true,
        menuBackgroundColor: appUIDarkColor,
        menuScreen: const DrawerBody(),
        mainScreen: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);


  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    Timer(
        const Duration(seconds: 1),
            () {
          if(!z.isOpen!()) {
            if (_controller.hasClients) {
              _controller.animateTo(_controller.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
            }
          }
        }
    );

    return Scaffold(
      backgroundColor: appUILightColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: appUILightColor,
              //color: Color.fromRGBO(150, 86, 190, 1),
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height * 0.07,
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                      builder: (context) {
                        return Material(
                          color: appUILightColor,
                          child: IconButton(
                            onPressed: () {
                              z.open!();
                            },
                            tooltip: "Menu",
                            icon: const Icon(Icons.menu),
                          ),
                        );
                      }
                  ),
                  Text(
                    "Bangtan Lyricz",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Material(
                    color: appUILightColor,
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      tooltip: "Search",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchSongs()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                //color: Color.fromRGBO(155, 107, 202, 1),
                //color: Color.fromRGBO(175, 144, 206, 1),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: const HomeScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DrawerBody extends StatelessWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //color: Color.fromRGBO(125, 60, 152, 1),
      color: appUIDarkColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              ///menu
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Menu",
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ///check for updates
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Material(
                      borderRadius: BorderRadius.circular(18),
                      elevation: 3,
                      color: Colors.transparent,
                      shadowColor: Colors.purple.shade700,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 14),
                              height: 55,
                              color: appUILightColor,
                              child: Row(
                                children: [
                                  const Icon(Icons.system_update_sharp, color: Colors.black),
                                  const SizedBox(width: 12),
                                  Text("Check for updates",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    //checkForUpdate();
                                    NativeUpdater.displayUpdateAlert(
                                      context,
                                      forceUpdate: true,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ///Favorites
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Material(
                      borderRadius: BorderRadius.circular(18),
                      elevation: 3,
                      color: Colors.transparent,
                      shadowColor: Colors.purple.shade700,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 14),
                              height: 55,
                              color: appUILightColor,
                              child: Row(
                                children: [
                                  const Icon(Icons.favorite_outline, color: Colors.black),
                                  const SizedBox(width: 12),
                                  Text("Favorites",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    z.close!();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesScreen()));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ///settings
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Material(
                      borderRadius: BorderRadius.circular(18),
                      elevation: 3,
                      color: Colors.transparent,
                      shadowColor: Colors.purple.shade700,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 14),
                              height: 55,
                              color: appUILightColor,
                              child: Row(
                                children: [
                                  const Icon(Icons.settings, color: Colors.black),
                                  const SizedBox(width: 12),
                                  Text("Settings",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    z.close!();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
