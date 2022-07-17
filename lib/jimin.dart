import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/lyricsKR.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Jimin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Jimin Songs";

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
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
                  fontSize: 22.0,
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
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: AlbumData().jiminOtherSongs.length,
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
                                          child: Image.asset(AlbumData().jiminOtherSongsArt[index]),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            AlbumData().jiminOtherSongs[index],
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
                                          AlbumData().jiminOtherSongs[index]) {
                                            case "약속 (Promise)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "약속 (PROMISE)",
                                                          songLyrics: AlbumData().jiminPromise,
                                                          songTabs: AlbumData().jiminOtherSongsTabs,
                                                          songFullName: AlbumData().jiminOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Christmas Love":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "CHRISTMAS LOVE",
                                                          songLyrics: AlbumData().jiminChristmasLove,
                                                          songTabs: AlbumData().jiminOtherSongsTabs,
                                                          songFullName: AlbumData().jiminOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "With You (Jimin x Ha Sung Woon)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "CHRISTMAS LOVE",
                                                          songLyrics: AlbumData().jiminWithYou,
                                                          songTabs: AlbumData().jiminOtherSongsTabs,
                                                          songFullName: AlbumData().jiminOtherSongs[index],
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
