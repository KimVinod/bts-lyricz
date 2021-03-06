import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class Jungkook extends StatelessWidget {
  const Jungkook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "Jungkook Songs";

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
                    itemCount: AlbumData().jungkookOtherSongs.length,
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
                                        child: Image.asset(AlbumData().jungkookOtherSongsArt[index]),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          AlbumData().jungkookOtherSongs[index],
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
                                        AlbumData().jungkookOtherSongs[index]) {
                                          case "Still With You":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "STILL WITH YOU",
                                                        songLyrics: AlbumData().jungkookStillWithYou,
                                                        songTabs: AlbumData().jungkookOtherSongsTabs,
                                                        songFullName: AlbumData().jungkookOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "???????????? (Working)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "???????????? (WORKING)",
                                                        songLyrics: AlbumData().jungkookWorking,
                                                        songTabs: AlbumData().jungkookOtherSongsTabs,
                                                        songFullName: AlbumData().jungkookOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Stay Alive (Prod. SUGA of BTS)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "STAY ALIVE",
                                                        songLyrics: AlbumData().jungkookStayAlive,
                                                        songTabs: AlbumData().jungkookOtherSongsTabs,
                                                        songFullName: AlbumData().jungkookOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "My You":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "MY YOU",
                                                        songLyrics: AlbumData().jungkookMyYou,
                                                        songTabs: AlbumData().jungkookOtherSongsTabs,
                                                        songFullName: AlbumData().jungkookOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Charlie Puth - Left And Right (ft. Jungkook of BTS)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsENG(
                                                        songName: "Left and Right",
                                                        songLyrics: AlbumData().jungkookLeftAndRight,
                                                        songTabs: AlbumData().jungkookEngTabs,
                                                        songFullName: AlbumData().jungkookOtherSongs[index],
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
