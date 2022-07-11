import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class LyricsJP extends StatefulWidget {
  final List<String>? songLyrics;
  final String? songName, songFullName;
  final List<int>? songTabs;

  LyricsJP({required this.songLyrics, required this.songName, required this.songTabs, required this.songFullName});

  @override
  State<LyricsJP> createState() => _LyricsJPState();
}

class _LyricsJPState extends State<LyricsJP> {

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
    print("load favList: $userFavLyrics");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final title = "Lyrics";

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text(title),
            backgroundColor: Color.fromRGBO(150, 86, 190, 1),
            bottom: TabBar(
              indicatorColor: Colors.purple[100],
              tabs: [
                Tab(text: "JP"),
                Tab(text: "ENG"),
                Tab(text: "ROM"),
              ],
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                tooltip: "Back",
                onPressed: () => Navigator.pop(context),
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
                print("current favList: $userFavLyrics");
              }, icon: Icon(isFav ? Icons.favorite :Icons.favorite_outline), tooltip: "Add to favorites",)
            ],
          ),
          body: TabBarView(
            children: [
              widget.songTabs![3] == 1 //JP
                  ? Container(
                      color: Color.fromRGBO(180, 136, 212, 1),
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 12, right: 5, bottom: 10),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification:
                              (OverscrollIndicatorNotification overScroll) {
                            overScroll.disallowIndicator();
                            return true;
                          },
                          child: widget.songLyrics![3] != ""
                              ? ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Text(
                                widget.songName!,
                                style: GoogleFonts.openSans(
                                    color: Colors.black,

                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                widget.songLyrics![3],
                                style: GoogleFonts.openSans(
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          )
                              : Container(
                            color: Color.fromRGBO(180, 136, 212, 1),
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
                      color: Color.fromRGBO(180, 136, 212, 1),
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
                      color: Color.fromRGBO(180, 136, 212, 1),
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 12, right: 5, bottom: 10),
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
                                    SizedBox(height: 20.0),
                                    Text(
                                      widget.songName!,
                                      style: GoogleFonts.openSans(
                                          color: Colors.black,

                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 12.0),
                                    Text(widget.songLyrics![0],
                                        style: GoogleFonts.openSans(fontSize: 16.0)),
                                    SizedBox(height: 10.0),
                                  ],
                                )
                              : Container(
                                  color: Color.fromRGBO(180, 136, 212, 1),
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
                      color: Color.fromRGBO(180, 136, 212, 1),
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
                      color: Color.fromRGBO(180, 136, 212, 1),
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 12, right: 5, bottom: 10),
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
                              SizedBox(height: 20.0),
                              Text(
                                widget.songName!,
                                style: GoogleFonts.openSans(
                                    color: Colors.black,

                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                widget.songLyrics![1],
                                style: GoogleFonts.openSans(
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          )
                              : Container(
                            color: Color.fromRGBO(180, 136, 212, 1),
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
                      color: Color.fromRGBO(180, 136, 212, 1),
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
      ),
    );
  }
}
