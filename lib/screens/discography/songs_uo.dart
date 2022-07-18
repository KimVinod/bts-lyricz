import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class SongsUO extends StatelessWidget {
  const SongsUO({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "BTS Unofficial Songs";

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
                  thumbVisibility: true,
                  thumbColor: const Color.fromRGBO(130, 70, 190, 1),
                  thickness: 7.0,
                  radius: const Radius.circular(15.0),
                  child: ListView.builder(
                    itemCount: AlbumData().btsOtherSongs.length,
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
                                        child: Image.asset(AlbumData().btsOtherSongsArt[index]),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          AlbumData().btsOtherSongs[index],
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
                                        AlbumData().btsOtherSongs[index]) {
                                          case "We Are Bulletproof Pt. 1 (4 BEGINS Ruff)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "WE ARE BULLETPROOF PT. 1",
                                                        songLyrics: AlbumData().btsWAB1,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "알아요 (I Know) by Rap Monster and Jungkook":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "알아요 (I KNOW)",
                                                        songLyrics: AlbumData().btsIKnow,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Family Song (Wednesday) by BTS and GFRIEND":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "FAMILY SONG (WEDNESDAY)",
                                                        songLyrics: AlbumData().btsWednesday,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "BTS x JESSI":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "BTS x JESSI",
                                                        songLyrics: AlbumData().btsBtsJessi,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "So Far Away (SUGA, Jin & Jungkook Ver.)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "SO FAR AWAY",
                                                        songLyrics: AlbumData().btsSoFarAway,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "With Seoul":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "WITH SEOUL",
                                                        songLyrics: AlbumData().btsWithSeoul,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "땡 (Ddaeng)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "땡 (DDAENG)",
                                                        songLyrics: AlbumData().btsDdaeng,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "You’re so Beautiful (LOTTE DUTY FREE x BTS)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "YOU'RE SO BEAUTIFUL",
                                                        songLyrics: AlbumData().btsLdf,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "IONIQ: I'm On It (Hyundai x BTS)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "IONIQ: I'M ON IT",
                                                        songLyrics: AlbumData().btsIoniq,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "In The SOOP":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "IN THE SOOP",
                                                        songLyrics: AlbumData().btsinTheSoop,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Born Singer":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "BORN SINGER",
                                                        songLyrics: AlbumData().btsBornSinger,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Beautiful":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "BEAUTIFUL",
                                                        songLyrics: AlbumData().btsBeautiful,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "95 Graduation by V and Jimin":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "95 GRADUATION",
                                                        songLyrics: AlbumData().bts95Graduation,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "So 4 More":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "SO 4 MORE",
                                                        songLyrics: AlbumData().btsSo4More,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
                                                      ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Christmas Day by Jimin and Jungkook":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LyricsKR(
                                                        songName: "CHRISTMAS DAY",
                                                        songLyrics: AlbumData().btsChristmasDay,
                                                        songTabs: AlbumData().btsOtherSongsTabs,
                                                        songFullName: AlbumData().btsOtherSongs[index],
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
