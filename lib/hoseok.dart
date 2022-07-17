import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/lyricsKR.dart';
import 'package:bts_lyrics_app/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Hoseok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "j-hope Albums and Songs";
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
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
                  /// hope world
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
                                image: DecorationImage(image: AssetImage("images/albums-solo/jhope/jhope-hopeworld.jpg"), fit: BoxFit.fill)
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              //splashColor: Colors.purple.shade200.withOpacity(0.5),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Songs(
                                    albumName: AlbumData().hopeWorldAlbumName,
                                    songNames: AlbumData().hopeWorldAlbumSongs,
                                    albumArt: AlbumData().hopeWorldArt,
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
                            "Hope World",
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

                  /// jack in the box
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
                                image: DecorationImage(image: AssetImage("images/albums-solo/jhope/jhope-jackInTheBox.jpg"), fit: BoxFit.fill)
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              //splashColor: Colors.purple.shade200.withOpacity(0.5),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Songs(
                                    albumName: AlbumData().jackInTheBoxAlbumName,
                                    songNames: AlbumData().jackInTheBoxAlbumSongs,
                                    albumArt: AlbumData().jackInTheBoxArt,
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
                            "Jack In The Box",
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
                        itemCount: AlbumData().jhopeOtherSongs.length,
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
                                            child: Image.asset(AlbumData().jhopeOtherSongsArt[index]),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              AlbumData().jhopeOtherSongs[index],
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
                                            switch (AlbumData().jhopeOtherSongs[index]) {
                                              case "1 Verse":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().jhope1Verse,
                                                        songName: "1 VERSE",
                                                        songTabs: AlbumData().jhopeOtherSongsTabs,
                                                        songFullName: AlbumData().jhopeOtherSongs[index],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "Chicken Noodle Soup (ft. Becky G)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().jhopeCNS,
                                                        songName: "CHICKEN NOODLE SOUP",
                                                        songTabs: AlbumData().jhopeOtherSongsTabs,
                                                        songFullName: AlbumData().jhopeOtherSongs[index],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "Blue Side":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().jhopeBlueSide,
                                                        songName: "BLUE SIDE",
                                                        songTabs: AlbumData().jhopeOtherSongsTabs,
                                                        songFullName: AlbumData().jhopeOtherSongs[index],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case "MORE":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "MORE",
                                                        songLyrics: AlbumData().jhopeMore,
                                                        songTabs: AlbumData().jhopeOtherSongsTabs,
                                                        songFullName: AlbumData().jhopeOtherSongs[index],
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
