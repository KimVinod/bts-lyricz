import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/lyricsJP.dart';
import 'package:bts_lyrics_app/lyricsKR.dart';
import 'package:bts_lyrics_app/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Yoongi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "SUGA/Agust D Albums and Songs";
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(title),
        backgroundColor: Color.fromRGBO(150, 86, 190, 1),
      ),
      body: Container(
        width: double.infinity,
        color: Color.fromRGBO(180, 136, 212, 1),
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
            SizedBox(height: 14.0),
            Container(
              height: 210,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
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
                                image: DecorationImage(image: AssetImage("images/albums-solo/suga/suga-agustd.jpg"), fit: BoxFit.fill)
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              //splashColor: Colors.purple.shade200.withOpacity(0.5),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Songs(
                                    albumName: AlbumData().agustdAlbumName,
                                    songNames: AlbumData().agustdAlbumSongs,
                                    albumArt: AlbumData().agustdArt,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 4),
                      SizedBox(
                        height: 20,
                        width: 150,
                        child: FittedBox(
                          child: Text(
                            "Agust D",
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



                  Column(
                    children: <Widget>[
                      Builder(
                        builder: (context) => Container(
                          height: 180,
                          child: Card(
                            child: Ink.image(
                              width: 160,
                              image:
                              AssetImage("images/albums-solo/suga/suga-d2.jpg"),
                              fit: BoxFit.fill,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Songs(
                                      albumName: AlbumData().d2AlbumName,
                                      songNames: AlbumData().d2AlbumSongs,
                                      albumArt: AlbumData().d2Art,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "D2",
                        style: GoogleFonts.openSans(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
                        itemCount: AlbumData().sugaOtherSongs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 85,
                                            height: 85,
                                            child: Image.asset(AlbumData().sugaOtherSongsArt[index]),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              AlbumData().sugaOtherSongs[index],
                                              style: GoogleFonts.openSans(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4)
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(20),
                                          onTap: () {
                                            switch (AlbumData().sugaOtherSongs[index]) {
                                              case "신청곡 (Song Request) (Lee Sora ft. SUGA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "신청곡 (SONG REQUEST)",
                                                        songLyrics: AlbumData().sugaSongRequest,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "Halsey, SUGA - SUGA’s Interlude":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "SUGA’s INTERLUDE",
                                                        songLyrics: AlbumData().sugaSugasInterlude,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "IU (아이유) - eight (에잇) (Prod. & ft. SUGA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "EIGHT (에잇)",
                                                        songLyrics: AlbumData().sugaEight,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "Blueberry Eyes (MAX ft. SUGA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "BLUEBERRY EYES",
                                                        songLyrics: AlbumData().sugaEight,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "ØMI - You (Prod. SUGA of BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songName: "YOU",
                                                        songLyrics: AlbumData().sugaYou,
                                                        songTabs: AlbumData().sugaYouTabs,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "Juice WRLD - Girl Of My Dreams (with Suga from BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "JUICE WRLD - GIRL OF MY DREAMS",
                                                        songLyrics: AlbumData().sugaGirlOfMyDreams,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
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
            ),
          ],
        ),
      ),
    );
  }
}
