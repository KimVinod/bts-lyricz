import 'package:bts_lyrics_app/data/lyrics_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:flutter/material.dart';
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

                /// the planet
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
                              image: const DecorationImage(image: AssetImage("images/singles/bts-thePlanet.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LyricsKR(
                                  songFullName: "The Planet",
                                  songName: "THE PLANET",
                                  songTabs: [1,1,1,0],
                                  songLyrics: getThePlanet,
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
                          "The Planet",
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

                /// don't every say you love me
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
                              image: const DecorationImage(image: AssetImage("images/albums-solo/rm/rm-dont-ever-say-love-me.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LyricsKR(
                                  songFullName: "다시는 사랑한다 말하지 마 (Don’t ever say love me) (Colde feat. RM of BTS)",
                                  songName: "다시는 사랑한다 말하지 마 (Don’t ever say love me)",
                                  songTabs: [1,1,1,0],
                                  songLyrics: getNamjoonDontEverSayLoveMe,
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
                          "Don’t ever say love me",
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

                /// d-day
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
                              image: const DecorationImage(image: AssetImage("images/albums-solo/suga/suga-d-day.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Songs(
                                  albumName: "D-DAY",
                                  albumArt: "images/albums-solo/suga/suga-d-day.jpg",
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
                          "D-DAY",
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

                /// people pt2
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
                              image: const DecorationImage(image: AssetImage("images/albums-solo/suga/suga-peoplept2.jpg"), fit: BoxFit.fill)
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            //splashColor: Colors.purple.shade200.withOpacity(0.5),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LyricsKR(
                                  songFullName: "사람 (People) Pt.2 (feat. IU (아이유))",
                                  songName: "사람 (PEOPLE) PT.2",
                                  songTabs: [1,1,1,0],
                                  songLyrics: getYoongiPeoplePt2,
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
                          "사람 (People) Pt.2",
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
