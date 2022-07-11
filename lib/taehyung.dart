import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/lyricsENG.dart';
import 'package:bts_lyrics_app/lyricsKR.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Taehyung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "V Songs";

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
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
                      itemCount: AlbumData().vOtherSongs.length,
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
                                          child: Image.asset(AlbumData().vOtherSongsArt[index]),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            AlbumData().vOtherSongs[index],
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
                                          AlbumData().vOtherSongs[index]) {
                                            case "풍경 (Scenery)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "풍경 (SCENERY)",
                                                          songLyrics: AlbumData().vScenery,
                                                          songTabs: AlbumData().vOtherSongsTabs,
                                                          songFullName: AlbumData().vOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Winter Bear":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsENG(
                                                          songName: "WINTER BEAR",
                                                          songLyrics: AlbumData().vWinterBear,
                                                          songTabs: AlbumData().vSongsEngTab,
                                                          songFullName: AlbumData().vOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Sweet Night":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsENG(
                                                          songName: "SWEET NIGHT",
                                                          songLyrics: AlbumData().vSweetNight,
                                                          songTabs: AlbumData().vSongsEngTab,
                                                          songFullName: AlbumData().vOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Snow Flower (ft. Peakboy)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "SNOW FLOWER",
                                                          songLyrics: AlbumData().vSnowFlower,
                                                          songTabs: AlbumData().vOtherSongsTabs,
                                                          songFullName: AlbumData().vOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Christmas Tree":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "CHRISTMAS TREE",
                                                          songLyrics: AlbumData().vChristmasTree,
                                                          songTabs: AlbumData().vOtherSongsTabs,
                                                          songFullName: AlbumData().vOtherSongs[index],
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
