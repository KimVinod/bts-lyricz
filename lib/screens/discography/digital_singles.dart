import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalSingles extends StatelessWidget {
  const DigitalSingles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "BTS Digital Singles";

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
                    itemCount: AlbumData().btsSinglesSongs.length,
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
                                        child: Image.asset(AlbumData().btsSinglesSongsArt[index]),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          AlbumData().btsSinglesSongs[index],
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
                                        AlbumData().btsSinglesSongs[index]) {
                                          case "Dynamite":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsENG(
                                                    songLyrics:
                                                    AlbumData().dynamiteLyrics,
                                                    songName: "DYNAMITE",
                                                    songTabs: AlbumData().dynamiteTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Butter":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsENG(
                                                    songLyrics: AlbumData().butterLyrics,
                                                    songName: "BUTTER",
                                                    songTabs: AlbumData().btsENGSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Butter (ft. Megan Thee Stallion)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsENG(
                                                    songLyrics: AlbumData().butterRemix,
                                                    songName: "BUTTER (FT. MEGAN THE STALLION)",
                                                    songTabs: AlbumData().btsENGSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "MIC Drop (Steve Aoki Remix) (ft. Desiigner)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsKR(
                                                    songLyrics: AlbumData().btsMICDropDesiigner,
                                                    songName: "MIC DROP",
                                                    songTabs: AlbumData().btsSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Waste It On Me":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsENG(
                                                    songLyrics: AlbumData().btsWasteItOnMe,
                                                    songName: "WASTE IT ON ME",
                                                    songTabs: AlbumData().btsENGSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Make It Right (ft. Lauv)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsKR(
                                                    songLyrics: AlbumData().btsMakeItRightLauv,
                                                    songName: "MAKE IT RIGHT",
                                                    songTabs: AlbumData().btsSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Black Swan":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsKR(
                                                    songLyrics:
                                                    AlbumData().mots7BlackSwan,
                                                    songName: "BLACK SWAN",
                                                    songTabs: AlbumData().btsSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Who (Lauv ft. BTS)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsENG(
                                                    songLyrics:
                                                    AlbumData().btsWho,
                                                    songName: "WHO",
                                                    songTabs: AlbumData().btsENGSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Film Out":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsJP(
                                                    songLyrics:
                                                    AlbumData().btsTheBestFilmOut,
                                                    songName: "FILM OUT",
                                                    songTabs: AlbumData().btsJPSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "Savage Love (Laxed - Siren Beat) (BTS Remix)":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsENG(
                                                    songLyrics:
                                                    AlbumData().btsSavageLove,
                                                    songName: "SAVAGE LOVE",
                                                    songTabs: AlbumData().btsENGSinglesTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],

                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case "My Universe":
                                            {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LyricsKR(
                                                    songLyrics: AlbumData().myUniverse,
                                                    songName: "MY UNIVERSE",
                                                    songTabs: AlbumData().myUniverseAlbumTabs,
                                                    songFullName: AlbumData().btsSinglesSongs[index],
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
