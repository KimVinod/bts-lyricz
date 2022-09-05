import 'dart:developer';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class LyricsKR extends StatefulWidget {
  final List<String>? songLyrics;
  final String? songName, songFullName;
  final List<int>? songTabs;

  const LyricsKR({Key? key ,required this.songLyrics, required this.songName, required this.songTabs, required this.songFullName}): super(key: key);

  @override
  State<LyricsKR> createState() => _LyricsKRState();
}

class _LyricsKRState extends State<LyricsKR> {

  late Box userFavLyricsBox;
  List userFavLyrics = [];
  bool isFav = false;

  loadData() async {
    userFavLyricsBox = await Hive.openBox('userFavourites');
    //userFavLyricsBox.clear();
    userFavLyrics = userFavLyricsBox.get('favouritesList',defaultValue: []);
    if(userFavLyrics.contains(widget.songFullName)) {
      setState(() {
        isFav = true;
      });
    }
    log("load favList: $userFavLyrics");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    const title = "Lyrics";

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
          backgroundColor: appBarColor,
          bottom: TabBar(
            indicatorColor: Colors.purple[100],
            tabs: const [
              Tab(text: "KOR"),
              Tab(text: "ENG"),
              Tab(text: "ROM"),
            ],
          ),
          actions: [
            IconButton(onPressed: () {
              if(userFavLyrics.contains(widget.songFullName)) {
                userFavLyrics.remove(widget.songFullName);
                setState(() {
                  isFav = false;
                });
              } else {
                userFavLyrics.add(widget.songFullName);
                setState(() {
                  isFav = true;
                });
              }
              userFavLyricsBox.put("favouritesList", userFavLyrics);
              log("current favList: $userFavLyrics");
            }, icon: Icon(isFav ? Icons.favorite :Icons.favorite_outline), tooltip: "Add to favorites",)
          ],
        ),
        body: TabBarView(
          children: [
            widget.songTabs![2] == 1 // KOR
                ? Container(
              color: appUILightColor,
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 12, right: 5, bottom: 10),
                child: NotificationListener<
                    OverscrollIndicatorNotification>(
                  onNotification:
                      (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: widget.songLyrics![2] != ""
                      ? ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      Text(
                        widget.songName!,
                        style: GoogleFonts.openSans(
                            color: Colors.black,

                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12.0),
                      SelectableText(
                        widget.songLyrics![2],
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  )
                      : Container(
                    color: appUILightColor,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "not available >.<",
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Container(
              color: appUILightColor,
              width: double.infinity,
              child: Center(
                child: Text(
                  "not available >.<",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            widget.songTabs![0] == 1 //ENG
                ? Container(
              color: appUILightColor,
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 12, right: 5, bottom: 10),
                child: NotificationListener<
                    OverscrollIndicatorNotification>(
                  onNotification:
                      (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: widget.songLyrics![0] != ""
                      ? ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      Text(
                        widget.songName!,
                        style: GoogleFonts.openSans(
                            color: Colors.black,

                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12.0),
                      SelectableText(
                        widget.songLyrics![0],
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  )
                      : Container(
                    color: appUILightColor,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "not available >.<",
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Container(
              color: appUILightColor,
              width: double.infinity,
              child: Center(
                child: Text(
                  "not available >.<",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            widget.songTabs![1] == 1 //ROM
                ? Container(
              color: appUILightColor,
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 12, right: 5, bottom: 10),
                child: NotificationListener<
                    OverscrollIndicatorNotification>(
                  onNotification:
                      (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: widget.songLyrics![1] != ""
                      ? ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      Text(
                        widget.songName!,
                        style: GoogleFonts.openSans(
                            color: Colors.black,

                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12.0),
                      SelectableText(
                        widget.songLyrics![1],
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  )
                      : Container(
                    color: appUILightColor,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "not available >.<",
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Container(
              color: appUILightColor,
              width: double.infinity,
              child: Center(
                child: Text(
                  "not available >.<",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
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
