import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:bts_lyrics_app/screens/songs/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class Namjoon extends StatelessWidget {
  const Namjoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "RM Albums and Songs";
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        backgroundColor: appBarColor,
      ),
      body: Container(
        width: double.infinity,
        color: appUILightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 14.0),
              child: Text(
                "Albums",
                style: GoogleFonts.openSans(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            SizedBox(
              height: 210,
              child: ListView(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(width: 5),

                  /// rm
                  Column(
                    children: <Widget>[
                      Material(
                          elevation: 3,
                          shadowColor: Colors.purple.shade700,
                          borderRadius: BorderRadius.circular(10),
                          child: Ink(
                            width: 150,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(image: AssetImage("images/albums-solo/rm/rm-mixtape.jpg"), fit: BoxFit.fill)
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              //splashColor: Colors.purple.shade200.withOpacity(0.5),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Songs(
                                    albumName: AlbumData().rmAlbumName,
                                    songNames: AlbumData().rmAlbumSongs,
                                    albumArt: AlbumData().rmArt,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 20,
                        width: 150,
                        child: FittedBox(
                          child: Text(
                            "RM",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),

                  /// mono
                  Column(
                    children: <Widget>[
                      Material(
                          elevation: 3,
                          shadowColor: Colors.purple.shade700,
                          borderRadius: BorderRadius.circular(10),
                          child: Ink(
                            width: 150,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(image: AssetImage("images/albums-solo/rm/rm-mono.jpg"), fit: BoxFit.fill)
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              //splashColor: Colors.purple.shade200.withOpacity(0.5),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Songs(
                                    albumName: AlbumData().monoAlbumName,
                                    songNames: AlbumData().monoAlbumSongs,
                                    albumArt: AlbumData().monoArt,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 20,
                        width: 150,
                        child: FittedBox(
                          child: Text(
                            "mono.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),

                  /// indigo
                  Column(
                    children: <Widget>[
                      Material(
                          elevation: 3,
                          shadowColor: Colors.purple.shade700,
                          borderRadius: BorderRadius.circular(10),
                          child: Ink(
                            width: 150,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(image: AssetImage("images/albums-solo/rm/rm-indigo.jpg"), fit: BoxFit.fill)
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              //splashColor: Colors.purple.shade200.withOpacity(0.5),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Songs(
                                    albumName: AlbumData().indigoAlbumName,
                                    songNames: AlbumData().indigoAlbumSongs,
                                    albumArt: AlbumData().indigoArt,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 20,
                        width: 150,
                        child: FittedBox(
                          child: Text(
                            "Indigo",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
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
                      itemCount: AlbumData().rmOtherSongs.length,
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
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 85,
                                          height: 85,
                                          child: Image.asset(AlbumData().rmOtherSongsArt[index]),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            AlbumData().rmOtherSongs[index],
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
                                          switch (AlbumData().rmOtherSongs[index]) {
                                            case "P.D.D (Please Don't Die) (Rap Monster x Warren G)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                      songName: "P.D.D",
                                                      songLyrics: AlbumData().rmPDD,
                                                      songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                    ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "부끄부끄 (Buckubucku) (MFBTY ft. EE, RM and Dino-J)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "부끄부끄 (Buckubucku)",
                                                          songLyrics: AlbumData().rmBuckubucku,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "U (Primary ft. 권진아 Kwon Jin Ah, Rap Monster)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "U",
                                                          songLyrics: AlbumData().rmU,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Change (RM & Wale)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsENG(
                                                          songName: "CHANGE",
                                                          songLyrics: AlbumData().rmChange,
                                                          songTabs: AlbumData().rmChangeTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Gajah (코끼리) (Gaeko (개코) ft. Rap Monster)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "GAJAH (코끼리)",
                                                          songLyrics: AlbumData().rmGajah,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Champion (Remix) (Fall Out Boy ft. RM)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsENG(
                                                          songName: "CHAMPION (REMIX)",
                                                          songLyrics: AlbumData().rmChampion,
                                                          songTabs: AlbumData().rmChampionTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Monterlude":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsENG(
                                                          songName: "MONTERLUDE",
                                                          songLyrics: AlbumData().rmMonterlude,
                                                          songTabs: AlbumData().rmMonterludeTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Unpack your Bags (SOULSCAPE x Rap Monster)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "UNPACK YOUR BAGS",
                                                          songLyrics: AlbumData().rmUnpackYourBags,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Always":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "ALWAYS",
                                                          songLyrics: AlbumData().rmAlways,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Timeless (Drunken Tiger ft. RM)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "TIMELESS",
                                                          songLyrics: AlbumData().rmTimeless,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Crying Over You ◐ (Remix) (HONNE ft. RM & BEKA)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsENG(
                                                          songName: "CRYING OVER YOU ◐ (REMIX)",
                                                          songLyrics: AlbumData().rmCryingOverYou,
                                                          songTabs: AlbumData().rmCryingOverYouTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Old Town Road (Seoul Town Road Remix) (Lil Nas ft. RM)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsENG(
                                                          songName: "OLD TOWN ROAD (SEOUL TOWN ROAD REMIX)",
                                                          songLyrics: AlbumData().rmSeoulTownRoad,
                                                          songTabs: AlbumData().rmSeoulTownRoadTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Winter Flower (雪中梅) (YOUNHA (윤하) ft. RM)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "WINTER FLOWER (雪中梅)",
                                                          songLyrics: AlbumData().rmWinterFlower,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "그러지 마 (Don’t) (eAeon (이이언) ft. RM)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "그러지 마 (DON’T)",
                                                          songLyrics: AlbumData().rmDont,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "Bicycle":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "BICYCLE",
                                                          songLyrics: AlbumData().rmBicycle,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
                                                        ),
                                                  ),
                                                );
                                              }
                                              break;
                                            case "SEXY NUKIM (섹시느낌) (Balming Tiger ft. RM of BTS)":
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LyricsKR(
                                                          songName: "SEXY NUKIM (섹시느낌)",
                                                          songLyrics: AlbumData().rmSexyNukim,
                                                          songTabs: AlbumData().rmOtherSongsTabs,
                                                          songFullName: AlbumData().rmOtherSongs[index],
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
                      }
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
