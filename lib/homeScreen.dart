import 'dart:async';

import 'package:bts_lyrics_app/searchSongs.dart';
import 'package:flutter/material.dart';
import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/albumsJP.dart';
import 'package:bts_lyrics_app/albums.dart';
import 'package:bts_lyrics_app/albumsUO.dart';
import 'package:bts_lyrics_app/hoseok.dart';
import 'package:bts_lyrics_app/jimin.dart';
import 'package:bts_lyrics_app/jin.dart';
import 'package:bts_lyrics_app/jungkook.dart';
import 'package:bts_lyrics_app/namjoon.dart';
import 'package:bts_lyrics_app/songs.dart';
import 'package:bts_lyrics_app/songsUO.dart';
import 'package:bts_lyrics_app/taehyung.dart';
import 'package:bts_lyrics_app/yoongi.dart';
import 'package:flutter/services.dart';
import 'package:bts_lyrics_app/digitalSingles.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lyricsENG.dart';
import 'lyricsKR.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final _controller = ScrollController();

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  void drawerClose() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    isDrawerOpen = false;
  }
  void drawerOpen() {
    xOffset = MediaQuery.of(context).size.width * 0.8;
    yOffset = MediaQuery.of(context).size.height * 0.07;
    scaleFactor = 0.88;
    isDrawerOpen = true;
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
        () {
        if(!isDrawerOpen){
          _controller.animateTo(_controller.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
      }
    );

    return WillPopScope(
      onWillPop: () async {
        if(isDrawerOpen) {
          setState(() {
           drawerClose();
          });
          return false;
        } else {
          return true;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Color.fromRGBO(180, 136, 212, 1),
            borderRadius: BorderRadius.circular(isDrawerOpen ? 16 : 0),
          ),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
          duration: Duration(milliseconds: 400),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(180, 136, 212, 1),
                  //color: Color.fromRGBO(150, 86, 190, 1),
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height * 0.07,
                  padding: EdgeInsets.only(top: 2, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerOpen
                          ? Material(
                        color: Color.fromRGBO(180, 136, 212, 1),
                        child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
                        tooltip: "Back",
                        onPressed: () {
                            setState(() {
                              drawerClose();
                            });
                        },
                      ),
                          )
                          : Material(
                        color: Color.fromRGBO(180, 136, 212, 1),
                        child: IconButton(
                        icon: Icon(Icons.menu, color: Colors.black),
                        tooltip: "Menu",
                        onPressed: () {
                            setState(() {
                              drawerOpen();
                            });
                        },
                      ),
                          ),
                      Text(
                        "Bangtan Lyricz",
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Material(
                        color: Color.fromRGBO(180, 136, 212, 1),
                        child: IconButton(
                          icon: Icon(Icons.search, color: Colors.black),
                          tooltip: "Search",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchSongs()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IgnorePointer(
                    ignoring: isDrawerOpen?true:false,
                    child: Container(
                      width: double.infinity,
                      //color: Color.fromRGBO(155, 107, 202, 1),
                      //color: Color.fromRGBO(175, 144, 206, 1),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (OverscrollIndicatorNotification overScroll) {
                          overScroll.disallowIndicator();
                          return true;
                        },
                        child: SingleChildScrollView(
                          controller: _controller,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 10.0),
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
                                SizedBox(height: 14.0),
                                Container(
                                  height: 210,
                                  child: ListView(
                                    padding: EdgeInsets.only(right: 10.0),
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    children: <Widget>[
                                      SizedBox(width: 5),

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
                                                    image: DecorationImage(image: AssetImage("images/albums-solo/jhope/jhope-more.jpg"), fit: BoxFit.fill)
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
                                      SizedBox(width: 10),

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
                                                    image: DecorationImage(image: AssetImage("images/albums-solo/jungkook/jungkook-leftandright.jpg"), fit: BoxFit.fill)
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
                                      SizedBox(width: 10),

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
                                                    image: DecorationImage(image: AssetImage("images/albums-solo/jungkook/jungkook-myyou.jpg"), fit: BoxFit.fill)
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
                                      SizedBox(width: 10),

                                      /// proof
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
                                                    image: DecorationImage(image: AssetImage("images/proof.jpg"), fit: BoxFit.fill)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Songs(
                                                        albumName: AlbumData().proofAlbumName,
                                                        songNames: AlbumData().proofAlbumSongs,
                                                        albumArt: AlbumData().proofArt,
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
                                                "Proof",
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
                                SizedBox(height: 10.0), // space above albums
                                Text(
                                  "Discography",
                                  style: GoogleFonts.openSans(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14.0),
                                Container(
                                  height: 190,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(right: 10.0),
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      SizedBox(width: 5),
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
                                                    image: DecorationImage(image: AssetImage("images/digital-singles.jpg"), fit: BoxFit.fill)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DigitalSingles())),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/kr-albums.jpg"), fit: BoxFit.fill)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumsKR())),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/jp-albums.jpg"), fit: BoxFit.fill)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumsJP())),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/uo-albums.jpg"), fit: BoxFit.fill)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumsUO())),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/uo-songs2.jpg"), fit: BoxFit.fill)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SongsUO())),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0), // space above solo
                                Text(
                                  "Solo Projects",
                                  style: GoogleFonts.openSans(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14.0), //space below solo
                                Container(
                                  height: 208,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(right: 10.0),
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      SizedBox(width: 5),
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
                                      image: DecorationImage(image: AssetImage("images/members/joon.jpg"), fit: BoxFit.cover)
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Namjoon())),
                                    ),
                                  )),
                                          SizedBox(height: 4),
                                          Text(
                                            "RM",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/members/jin.jpg"), fit: BoxFit.cover)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Jin())),
                                                ),
                                              )),
                                          SizedBox(height: 4),
                                          Text(
                                            "Jin",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/members/yoongi.jpg"), fit: BoxFit.cover)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Yoongi())),
                                                ),
                                              )),
                                          SizedBox(height: 4),
                                          Text(
                                            "SUGA / Agust D",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/members/hobi.jpg"), fit: BoxFit.cover)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Hoseok())),
                                                ),
                                              )),
                                          SizedBox(height: 4),
                                          Text(
                                            "j-hope",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/members/jimin.jpg"), fit: BoxFit.cover)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Jimin())),
                                                ),
                                              )),
                                          SizedBox(height: 4),
                                          Text(
                                            "Jimin",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/members/tae.jpg"), fit: BoxFit.cover)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Taehyung())),
                                                ),
                                              )),
                                          SizedBox(height: 4),
                                          Text(
                                            "V",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
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
                                                    image: DecorationImage(image: AssetImage("images/members/jk.jpg"), fit: BoxFit.cover)
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(10),
                                                  //splashColor: Colors.purple.shade200.withOpacity(0.5),
                                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Jungkook())),
                                                ),
                                              )),
                                          SizedBox(height: 4),
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
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
