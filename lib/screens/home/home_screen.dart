import 'package:flutter/material.dart';
import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/discography/albums_jp.dart';
import 'package:bts_lyrics_app/screens/discography/albums_kr.dart';
import 'package:bts_lyrics_app/screens/discography/albums_uo.dart';
import 'package:bts_lyrics_app/screens/members/jin.dart';
import 'package:bts_lyrics_app/screens/members/jungkook.dart';
import 'package:bts_lyrics_app/screens/members/namjoon.dart';
import 'package:bts_lyrics_app/screens/songs/songs.dart';
import 'package:bts_lyrics_app/screens/discography/songs_uo.dart';
import 'package:bts_lyrics_app/screens/members/taehyung.dart';
import 'package:bts_lyrics_app/screens/members/yoongi.dart';
import 'package:bts_lyrics_app/screens/members/hoseok.dart';
import 'package:bts_lyrics_app/screens/members/jimin.dart';
import 'package:bts_lyrics_app/screens/discography/digital_singles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "New Releases",
            style: GoogleFonts.openSans(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14.0),
          SizedBox(
            height: 210,
            child: ListView(
              padding: const EdgeInsets.only(right: 10.0),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                const SizedBox(width: 5),

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
                              image: const DecorationImage(image: AssetImage("images/albums-solo/jhope/jhope-jackInTheBox.jpg"), fit: BoxFit.fill)
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
                    const SizedBox(height: 4),
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
                const SizedBox(width: 10),
                /// MORE
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
                              image: const DecorationImage(image: AssetImage("images/albums-solo/jhope/jhope-more.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LyricsKR(
                                  songName: "MORE",
                                  songLyrics: AlbumData().jhopeMore,
                                  songTabs: AlbumData().jhopeOtherSongsTabs,
                                  songFullName: "MORE",
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
                          "MORE",
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

                /// left and right
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
                              image: const DecorationImage(image: AssetImage("images/albums-solo/jungkook/jungkook-leftandright.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LyricsENG(
                                  songName: "Left and Right",
                                  songLyrics: AlbumData().jungkookLeftAndRight,
                                  songTabs: AlbumData().jungkookEngTabs,
                                  songFullName: "Charlie Puth - Left And Right (ft. Jungkook of BTS)",
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
                          "Left and Right",
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

                /// my you
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
                              image: const DecorationImage(image: AssetImage("images/albums-solo/jungkook/jungkook-myyou.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LyricsKR(
                                  songName: "MY YOU",
                                  songLyrics: AlbumData().jungkookMyYou,
                                  songTabs: AlbumData().jungkookOtherSongsTabs,
                                  songFullName: "My You",
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
                          "My You",
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
          const SizedBox(height: 10.0), // space above albums
          Text(
            "Discography",
            style: GoogleFonts.openSans(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14.0),
          SizedBox(
            height: 190,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 10.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                const SizedBox(width: 5),
                ///digital singles
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
                              image: const DecorationImage(image: AssetImage("images/digital-singles.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DigitalSingles())),
                          ),
                        )),
                  ],
                ),
                const SizedBox(width: 10),
                ///kr albums
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
                              image: const DecorationImage(image: AssetImage("images/kr-albums.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AlbumsKR())),
                          ),
                        )),
                  ],
                ),
                const SizedBox(width: 10),
                ///jp albums
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
                              image: const DecorationImage(image: AssetImage("images/jp-albums.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AlbumsJP())),
                          ),
                        )),
                  ],
                ),
                const SizedBox(width: 10),
                ///uo albums
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
                              image: const DecorationImage(image: AssetImage("images/uo-albums.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AlbumsUO())),
                          ),
                        )),
                  ],
                ),
                const SizedBox(width: 10),
                ///uo albums
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
                              image: const DecorationImage(image: AssetImage("images/uo-songs2.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SongsUO())),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0), // space above solo
          Text(
            "Solo Projects",
            style: GoogleFonts.openSans(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14.0), //space below solo
          SizedBox(
            height: 208,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 10.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                const SizedBox(width: 5),
                ///joon
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
                              image: const DecorationImage(image: AssetImage("images/members/joon.jpg"), fit: BoxFit.cover)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Namjoon())),
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      "RM",
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                ///jin
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
                              image: const DecorationImage(image: AssetImage("images/members/jin.jpg"), fit: BoxFit.cover)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Jin())),
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      "Jin",
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                ///yoongi
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
                              image: const DecorationImage(image: AssetImage("images/members/yoongi.jpg"), fit: BoxFit.cover)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Yoongi())),
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      "SUGA / Agust D",
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                ///hobi
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
                              image: const DecorationImage(image: AssetImage("images/members/hobi.jpg"), fit: BoxFit.cover)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Hoseok())),
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      "j-hope",
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                ///jimin
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
                              image: const DecorationImage(image: AssetImage("images/members/jimin.jpg"), fit: BoxFit.cover)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Jimin())),
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      "Jimin",
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                ///tae
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
                              image: const DecorationImage(image: AssetImage("images/members/tae.jpg"), fit: BoxFit.cover)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Taehyung())),
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      "V",
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                ///jk
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
                              image: const DecorationImage(image: AssetImage("images/members/jk.jpg"), fit: BoxFit.cover)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Jungkook())),
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      "Jungkook",
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
