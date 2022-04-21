import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    //get package details
    _initPackageInfo();
  }

  Future<Null> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        width: double.infinity,
        //color: Color.fromRGBO(125, 60, 152, 1),
        color: Color.fromRGBO(91, 50, 120, 1),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 2),
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
                              fontSize: 26),
                      ),
                      SizedBox(height: 20),
                      ///check for updates
                      /*Container(
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
                                      Icon(Icons.system_update_sharp, color: Colors.black),
                                      SizedBox(width: 14),
                                      Text("Check for updates",
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        try{
                                          final result = await InternetAddress.lookup("www.google.com");
                                          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                            var url = Uri.parse('https://kimvinod.github.io/bts-lyrics/checkForUpdates.json');
                                            Future getData() async {
                                              final req = await http.get(url);
                                              if (req.statusCode == 200) {
                                                final body = req.body;
                                                final res = json.decode(body);
                                                return res;
                                              } else {
                                                return json.decode(req.body);
                                              }
                                            }
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => Center(
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height * 0.4,
                                                  width: MediaQuery.of(context).size.width * 0.75,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(180, 136, 212, 1),
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                  ),
                                                  child: FutureBuilder(
                                                    future: getData(),
                                                    builder: (context, AsyncSnapshot snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: Container(
                                                            height: 60,
                                                            width: 60,
                                                            child: CircularProgressIndicator(
                                                              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(91, 50, 120, 1)),
                                                              strokeWidth: 6,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        final data = snapshot.data[0];
                                                        final int versionCode = data["versionCode"];
                                                        if (int.parse(_packageInfo.buildNumber) < versionCode) {
                                                          return Container(
                                                            padding: EdgeInsets.all(8),
                                                            height: MediaQuery.of(context).size.height * 0.4,
                                                            width: MediaQuery.of(context).size.width * 0.75,
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(180, 136, 212, 1),
                                                              borderRadius:
                                                              BorderRadius.circular(20),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  child: Text("New Update Available",
                                                                    style: GoogleFonts.openSans(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 24
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    data["notes"],
                                                                    textAlign: TextAlign.center,
                                                                    style: GoogleFonts.openSans(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 17
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 45,
                                                                  width: 100,
                                                                  child: TextButton(
                                                                    onPressed: () async {
                                                                      Navigator.of(context).pop();
                                                                      final url = data["updateUrl"];
                                                                      print(url);
                                                                      if(await canLaunch(url))
                                                                        launch(url);
                                                                      else {
                                                                        Fluttertoast.showToast(
                                                                          msg: "Error occurred. Your phone doesn't support opening links",
                                                                          toastLength: Toast.LENGTH_SHORT,
                                                                          fontSize: 15,
                                                                        );
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        "UPDATE",
                                                                        style: GoogleFonts.openSans(color: Colors.white, fontSize: 16)
                                                                    ),
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(91, 50, 120, 1)),
                                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                      overlayColor: MaterialStateProperty.all(Color.fromRGBO(180, 136, 212, 0.4)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        } else {
                                                          return Container(
                                                            padding: EdgeInsets.all(8),
                                                            height: MediaQuery.of(context).size.height * 0.4,
                                                            width: MediaQuery.of(context).size.width * 0.75,
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(180, 136, 212, 1),
                                                              borderRadius:
                                                              BorderRadius.circular(20),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  child: Text("No Update Found",
                                                                    style: GoogleFonts.openSans(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 24
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    "You are currently running the latest version.",
                                                                    textAlign: TextAlign.center,
                                                                    style: GoogleFonts.openSans(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 20
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 45,
                                                                  width: 100,
                                                                  child: TextButton(
                                                                    onPressed: () => Navigator.of(context).pop(),
                                                                    child: Text(
                                                                        "DISCARD",
                                                                        style: GoogleFonts.openSans(color: Colors.white, fontSize: 16)),
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(91, 50, 120, 1)),
                                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                      overlayColor: MaterialStateProperty.all(Color.fromRGBO(180, 136, 212, 0.4)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );

                                          }
                                        } on SocketException catch (_) {
                                          Fluttertoast.showToast(
                                            msg: "You are not connected to internet.\nTry again later.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            //gravity: ToastGravity.BOTTOM,
                                            //backgroundColor: Color.fromRGBO(180, 136, 212, 1),
                                            //textColor: Colors.black,
                                            fontSize: 15,
                                          );
                                        }

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),*/
                      ///help
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
                                              fontSize: 18
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
                                              height: MediaQuery.of(context).size.height * 0.7,
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
                                                          radius: Radius.circular(20),
                                                          thumbColor: Color.fromRGBO(130, 70, 190, 1),
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
                                                                SizedBox(height: 15),
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
                                                                SizedBox(height: 5),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                                            if(await canLaunch(url))
                                                              launch(url);
                                                            else {
                                                              Fluttertoast.showToast(
                                                                msg: "Error occurred. Your phone doesn't support opening links",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                fontSize: 15,
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
                                                          "\tor\t",
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
                                                            if(await canLaunch(emailLaunchUri.toString()))
                                                              launch(emailLaunchUri.toString());
                                                            else {
                                                              Fluttertoast.showToast(
                                                                msg: "Error occurred. Your phone doesn't support opening links",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                fontSize: 15,
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
                                              fontSize: 18)),
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
                                                        "BTS Lyricz",
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
                                                            image: DecorationImage(image: AssetImage("images/bts-logo.png")),
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
                      ),
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
