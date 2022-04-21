import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumsJP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "BTS Japanese Albums";
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        //backgroundColor: Colors.purple[400],
        backgroundColor: Color.fromRGBO(150, 86, 190, 1),
        title: Text(title),
      ),
      body: Container(
        width: double.infinity,
        //color: Colors.purple[200],
        color: Color.fromRGBO(180, 136, 212, 1),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: GridView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.77),
            children: <Widget>[
              /// no more dream
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/nomoredream.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().noMoreDreamAlbumName,
                                songNames: AlbumData().noMoreDreamAlbumSongs,
                                albumArt: AlbumData().noMoreDreamArt,
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
                        "No More Dream",
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
              /// boy in luv
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/boyinluv.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().boyInLuvAlbumName,
                                songNames: AlbumData().boyInLuvAlbumSongs,
                                albumArt: AlbumData().boyInLuvArt,
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
                        "Boy In Luv",
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
              /// danger
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/danger.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().dangerAlbumName,
                                songNames: AlbumData().dangerAlbumSongs,
                                albumArt: AlbumData().dangerArt,
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
                        "Danger",
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
              /// wake up
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/wakeup.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().wakeUpAlbumName,
                                songNames: AlbumData().wakeUpAlbumSongs,
                                albumArt: AlbumData().wakeUpArt,
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
                        "Wake Up",
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
              /// for you
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/foryou.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().forYouAlbumName,
                                songNames: AlbumData().forYouAlbumSongs,
                                albumArt: AlbumData().forYouArt,
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
                        "For You",
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
              /// inu
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/ineedu.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().iNeedUAlbumName,
                                songNames: AlbumData().iNeedUAlbumSongs,
                                albumArt: AlbumData().iNeedUArt,
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
                        "I NEED U",
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
              /// run
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/run.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().runAlbumName,
                                songNames: AlbumData().runAlbumSongs,
                                albumArt: AlbumData().runArt,
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
                        "Run",
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
              /// youth
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/youth.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().youthAlbumName,
                                songNames: AlbumData().youthAlbumSongs,
                                albumArt: AlbumData().youthArt,
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
                        "Youth",
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
              /// bst
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/bst.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().bstAlbumName,
                                songNames: AlbumData().bstAlbumSongs,
                                albumArt: AlbumData().bstArt,
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
                        "Blood Sweat & Tears",
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
              /// crystal snow
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/crystalsnow.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().crystalSnowAlbumName,
                                songNames: AlbumData().crystalSnowAlbumSongs,
                                albumArt: AlbumData().crystalSnowArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 4),
                  Text(
                    "MIC DROP / DNA /\nCrystal Snow",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// face yourself
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/faceyourself.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().faceYourselfAlbumName,
                                songNames: AlbumData().faceYourselfAlbumSongs,
                                albumArt: AlbumData().faceYourselfArt,
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
                        "Face Yourself",
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
              /// fl airplane pt2
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/fl-airplane2.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().fakeLoveAlbumName,
                                songNames: AlbumData().fakeLoveAlbumSongs,
                                albumArt: AlbumData().fakeLoveArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 4),
                  Text(
                    "FAKE LOVE /\nAirplane pt.2",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// lights bwl
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/lights.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().lightsAlbumName,
                                songNames: AlbumData().lightsAlbumSongs,
                                albumArt: AlbumData().lightsArt,
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
                        "Lights / Boy With Luv",
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
              /// mots7 the journey
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/mots7thejourney.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().motsJourneyAlbumName,
                                songNames: AlbumData().motsJourneyAlbumSongs,
                                albumArt: AlbumData().motsJourneyArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 4),
                  Text(
                    "Map Of The Soul: 7\n~ The Journey ~",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// bts the best
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
                            image: DecorationImage(image: AssetImage("images/albums-jp/btsthebest.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().btsTheBestAlbumName,
                                songNames: AlbumData().btsTheBestAlbumSongs,
                                albumArt: AlbumData().btsTheBestArt,
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
                        "BTS, THE BEST",
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
      ),
    );
  }
}
