import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class Taehyung extends StatelessWidget {
  const Taehyung({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "V Songs";

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        backgroundColor: appBarColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: appUILightColor,
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
            const SizedBox(height: 12.0),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: Expanded(
                child: RawScrollbar(
                  thumbColor: const Color.fromRGBO(130, 70, 190, 1),
                  thickness: 7.0,
                  radius: const Radius.circular(15.0),
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
                                      color: const Color.fromRGBO(152, 105, 190, 1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 85,
                                        height: 85,
                                        child: Image.asset(AlbumData().vOtherSongsArt[index]),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          AlbumData().vOtherSongs[index],
                                          style: GoogleFonts.openSans(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
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
                                          case "?????? (Scenery)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "?????? (SCENERY)",
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
          ],
        ),
      ),
    );
  }
}
