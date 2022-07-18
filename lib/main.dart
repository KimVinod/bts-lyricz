import 'package:bts_lyrics_app/homeScreen.dart';
import 'package:bts_lyrics_app/settings_screen.dart';
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
import 'package:bts_lyrics_app/searchSongs.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_updater/native_updater.dart';

import 'favorites_screen.dart';

final ZoomDrawerController z = ZoomDrawerController();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel", //id
  "BTS Related Notification Channel", //title
  importance: Importance.high,
  playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("A BG msg just showed up: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  if(kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    FirebaseCrashlytics.instance.deleteUnsentReports();
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  runApp(MaterialApp(
      home: BTSLyrics(),
    theme: ThemeData(
      textTheme: GoogleFonts.openSansTextTheme(),
      primaryColor: const Color.fromRGBO(180, 136, 212, 1),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color.fromRGBO(180, 136, 212, 1))
    ),
  ));
}

class BTSLyrics extends StatefulWidget {

  @override
  _BTSLyricsState createState() => _BTSLyricsState();
}

class _BTSLyricsState extends State<BTSLyrics> {

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FG");
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
      print('A new onMessageOpenedApp event was published!');
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
        menuBackgroundColor: const Color.fromRGBO(91, 50, 120, 1),
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
          if(!z.isOpen!())
            if (_controller.hasClients) {
              _controller.animateTo(_controller.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
            }
        }
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(180, 136, 212, 1),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: const Color.fromRGBO(180, 136, 212, 1),
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
                          color: const Color.fromRGBO(180, 136, 212, 1),
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
                    color: const Color.fromRGBO(180, 136, 212, 1),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      tooltip: "Search",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchSongs()));
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
      color: const Color.fromRGBO(91, 50, 120, 1),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              ///menu
              Container(
                child: Column(
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
                                color: const Color.fromRGBO(180, 136, 212, 1),
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
                                color: const Color.fromRGBO(180, 136, 212, 1),
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
                    /*///help
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        color: Colors.transparent,
                        shadowColor: Colors.purple.shade700,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 14),
                                height: 56,
                                color: Color.fromRGBO(180, 136, 212, 1),
                                child: Row(
                                  children: [
                                    Icon(Icons.help_outline,
                                        color: Colors.black),
                                    SizedBox(width: 14),
                                    Text("Help",
                                        style: GoogleFonts.openSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17
                                        ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      String? encodeQueryParameters(Map<String, String> params) {
                                        return params.entries
                                            .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                            .join('&');
                                      }

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => Center(
                                          child: Container(
                                            padding: EdgeInsets.only(top: 8),
                                            height: MediaQuery.of(context).size.height * 0.75,
                                            width: MediaQuery.of(context).size.width * 0.85,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(180, 136, 212, 1),
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    "Help",
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 24
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 26),
                                                NotificationListener<OverscrollIndicatorNotification>(
                                                  onNotification: (OverscrollIndicatorNotification overScroll) {
                                                    overScroll.disallowIndicator();
                                                    return true;
                                                  },
                                                  child: Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                      child: RawScrollbar(
                                                        thumbVisibility: true,
                                                        radius: Radius.circular(20),
                                                        thumbColor: Color.fromRGBO(130, 70, 190, 0.6),
                                                        child: SingleChildScrollView(
                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "1. Unofficial songs sung by two or more members are listed under Discography -> Unofficial Songs.",
                                                                style: GoogleFonts.openSans(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 15
                                                                ),
                                                              ),

                                                              SizedBox(height: 30),
                                                              Text(
                                                                "2. Songs released before debut are currently not listed.",
                                                                style: GoogleFonts.openSans(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 15
                                                                ),
                                                              ),
                                                              SizedBox(height: 30),
                                                              Text(
                                                                "3. How to enable/disable notifications?\nGo to app info -> notifications -> turn on/off. ",
                                                                style: GoogleFonts.openSans(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 15
                                                                ),
                                                              ),
                                                              SizedBox(height: 30),
                                                              Text(
                                                                "4. Notifications not working?.\n"
                                                                    "Your phone restricts notifications to increase battery life.\nTry doing these following steps:\n\n"
                                                                    "   - Enable auto-start from settings/app info.\n\n"
                                                                    "   - Disable battery optimization from settings/battery/app info.\n",
                                                                style: GoogleFonts.openSans(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 15
                                                                ),
                                                              ),
                                                              SizedBox(height: 10),
                                                              Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                                                  child: Text(
                                                                    "Special thanks to translator armys & genius.com for the lyrics :)",
                                                                    textAlign: TextAlign.center,
                                                                    style: GoogleFonts.openSans(
                                                                        color: Colors.black,
                                                                        fontStyle: FontStyle.italic,
                                                                        //fontWeight: FontWeight.w600,
                                                                        fontSize: 14
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 20),
                                                              Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        "App source code available on\t",
                                                                        textAlign: TextAlign.center,
                                                                        style: GoogleFonts.openSans(
                                                                            color: Colors.black,
                                                                            //fontStyle: FontStyle.italic,
                                                                            //fontWeight: FontWeight.w600,
                                                                            fontSize: 14
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () async {
                                                                          final String url = "https://github.com/KimVinod/bts-lyricz";
                                                                          if(await canLaunchUrlString(url))
                                                                          launchUrlString(url, mode: LaunchMode.externalApplication);
                                                                          else {
                                                                          Fluttertoast.showToast(
                                                                          msg: "Error occurred. Your phone doesn't support opening links",
                                                                          toastLength: Toast.LENGTH_SHORT,
                                                                          );
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                          "GitHub",
                                                                          textAlign: TextAlign.center,
                                                                          style: GoogleFonts.openSans(
                                                                              color: Colors.black,
                                                                              //fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 20),
                                                              Center(
                                                                child: Wrap(
                                                                  children: [
                                                                    Text(
                                                                      "Found a bug? dm me on\t",
                                                                      textAlign: TextAlign.center,
                                                                      style: GoogleFonts.openSans(
                                                                          color: Colors.black,
                                                                          //fontWeight: FontWeight.w600,
                                                                          fontSize: 13
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        //await launch("https://twitter.com/vinod3344");
                                                                        final String url = "https://twitter.com/vinod3344";
                                                                        if(await canLaunchUrlString(url))
                                                                          launchUrlString(url,mode: LaunchMode.externalApplication);
                                                                        else {
                                                                          Fluttertoast.showToast(
                                                                            msg: "Error occurred. Your phone doesn't support opening links",
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                          );
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        "Twitter",
                                                                        textAlign: TextAlign.center,
                                                                        style: GoogleFonts.openSans(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 13
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "or\t",
                                                                      textAlign: TextAlign.center,
                                                                      style: GoogleFonts.openSans(
                                                                          color: Colors.black,
                                                                          //fontWeight: FontWeight.w600,
                                                                          fontSize: 13
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        final Uri emailLaunchUri = Uri(
                                                                          scheme: 'mailto',
                                                                          path: 'vinoddevendran34@gmail.com',
                                                                          query: encodeQueryParameters(<String, String>{
                                                                            'subject': '[${_packageInfo.appName}] [Bug] [v${_packageInfo.version}]'
                                                                          }),
                                                                        );
                                                                        //await launch(emailLaunchUri.toString());
                                                                        if(await canLaunchUrlString(emailLaunchUri.toString()))
                                                                          launchUrlString(emailLaunchUri.toString(), mode: LaunchMode.externalApplication);
                                                                        else {
                                                                          Fluttertoast.showToast(
                                                                            msg: "Error occurred. Your phone doesn't support opening links",
                                                                            toastLength: Toast.LENGTH_SHORT,

                                                                          );
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        "Email",
                                                                        textAlign: TextAlign.center,
                                                                        style: GoogleFonts.openSans(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 13
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 4),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),
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
                    SizedBox(height: 15),
                    /// about
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        color: Colors.transparent,
                        shadowColor: Colors.purple.shade700,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 14),
                                height: 56,
                                color: Color.fromRGBO(180, 136, 212, 1),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline,
                                        color: Colors.black),
                                    SizedBox(width: 14),
                                    Text("About",
                                        style: GoogleFonts.openSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => Center(
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            height: MediaQuery.of(context).size.height * 0.6,
                                            width: MediaQuery.of(context).size.width * 0.75,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(180, 136, 212, 1),
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "About",
                                                  style: GoogleFonts.openSans(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 24
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Bangtan Lyricz",
                                                      style: GoogleFonts.openSans(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 19
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Container(
                                                      height: 140,
                                                      width: 140,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(image: AssetImage("images/app-icon-new2.png")),
                                                          borderRadius: BorderRadius.circular(20)
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text(
                                                      "Version: "+_packageInfo.version,
                                                      style: GoogleFonts.openSans(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Made by ARMY\nMade for ARMY\nMade with borahae 💜",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
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
                                color: const Color.fromRGBO(180, 136, 212, 1),
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
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
