import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LyricsENG extends StatelessWidget {
  final List<String>? songLyrics;
  final String? songName;
  final List<int>? songTabs;

  LyricsENG({this.songLyrics, this.songName, this.songTabs});

  @override
  Widget build(BuildContext context) {
    final title = "Lyrics";
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text(title),
            backgroundColor: Color.fromRGBO(150, 86, 190, 1),
            bottom: TabBar(
              indicatorColor: Colors.purple[100],
              tabs: [Tab(text: "ENG")],
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                tooltip: "Back",
                onPressed: () => Navigator.pop(context)),
          ),
          body: TabBarView(
            children: [
              songTabs![0] == 1 //ENG
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
                          child: songLyrics![0] != ""
                              ? ListView(
                                  scrollDirection: Axis.vertical,
                                  children: <Widget>[
                                    SizedBox(height: 20.0),
                                    Text(
                                      songName!,
                                      style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          letterSpacing: 1.0,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 12.0),
                                    Text(
                                      songLyrics![0],
                                      style: GoogleFonts.openSans(
                                        fontSize: 17.0,
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
