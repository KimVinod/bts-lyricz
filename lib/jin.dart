import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/lyricsKR.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Jin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Jin Songs";

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        //brightness: Brightness.dark,
        title: Text(title),
        backgroundColor: Color.fromRGBO(150, 86, 190, 1),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(180, 136, 212, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 14.0),
              child: Text(
                "Songs",
                style: GoogleFonts.openSans(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: Expanded(
                child: Container(
                  child: RawScrollbar(
                    thumbColor: Color.fromRGBO(130, 70, 190, 1),
                    thickness: 7.0,
                    radius: Radius.circular(15.0),
                    isAlwaysShown: true,
                    child: ListView.builder(
                      itemCount: AlbumData().jinOtherSongs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 3,
                            color: Colors.transparent,
                            shadowColor: Colors.purple.shade700,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 85,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(152, 105, 190, 1),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 85,
                                          height: 85,
                                          child: Image.asset(AlbumData().jinOtherSongsArt[index]),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            AlbumData().jinOtherSongs[index],
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          switch (
                                              AlbumData().jinOtherSongs[index]) {
                                            case "이 밤 (Tonight)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                      songName: "이 밤 (TONIGHT)",
                                                      songLyrics: AlbumData().jinTonight,
                                                      songTabs: AlbumData().jinOtherSongsTabs,
                                                    ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Abyss":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "ABYSS",
                                                          songLyrics: AlbumData().jinAbyss,
                                                          songTabs: AlbumData().jinOtherSongsTabs,
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Yours":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => LyricsKR(
                                                      songName: "YOURS",
                                                      songLyrics: AlbumData().jinYours,
                                                      songTabs: AlbumData().jinOtherSongsTabs,
                                                    ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "슈퍼 참치 (Super Tuna)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => LyricsKR(
                                                      songName: "슈퍼 참치 (SUPER TUNA)",
                                                      songLyrics: AlbumData().jinSuperTuna,
                                                      songTabs: AlbumData().jinOtherSongsTabs,
                                                    ),
                                                  ),
                                                );
                                              }
                                              break;
                                          }
                                        },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
