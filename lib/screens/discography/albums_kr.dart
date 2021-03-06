import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/songs/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class AlbumsKR extends StatelessWidget {
  const AlbumsKR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "BTS Albums";
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        //backgroundColor: Colors.purple[400],
        backgroundColor: appBarColor,
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
      ),
      body: Container(
        width: double.infinity,
        //color: Colors.purple[200],
        color: appUILightColor,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: GridView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.73),
            children: <Widget>[
              /// 2 cool 4 skool
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
                            image: const DecorationImage(image: AssetImage("images/2cool4skool.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName:
                                AlbumData().twoCool4SkoolAlbumName,
                                songNames: AlbumData()
                                    .twoCool4SkoolAlbumSongs,
                                albumArt: AlbumData().twoCool4SkoolArt,
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
                        "2 Cool 4 Skool",
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
              /// o!rul8,2?
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
                            image: const DecorationImage(image: AssetImage("images/o!rul8,2.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName:
                                AlbumData().orul82AlbumName,
                                songNames: AlbumData().orul82AlbumSongs,
                                albumArt: AlbumData().orul82Art,
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
                        "O!RUL8,2?",
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
              /// skool luv affair
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
                            image: const DecorationImage(image: AssetImage("images/skoolluvaffair.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().skoolLuvAffairAlbumName,
                                songNames: AlbumData().skoolLuvAffairAlbumSongs,
                                albumArt: AlbumData().skoolLuvAffairArt,
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
                        "Skool Luv Affair",
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
              /// dark and wild
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
                            image: const DecorationImage(image: AssetImage("images/darkandwild.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().darkAndWildAlbumName,
                                songNames: AlbumData().darkAndWildAlbumSongs,
                                albumArt: AlbumData().darkAndWildArt,
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
                        "Dark & Wild",
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
              /// hyyh1
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
                            image: const DecorationImage(image: AssetImage("images/hyyh1.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().hyyh1AlbumName,
                                songNames: AlbumData().hyyh1AlbumSongs,
                                albumArt: AlbumData().hyyh1Art,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "The most beautiful moment in life pt.1",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// hyyh2
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
                            image: const DecorationImage(image: AssetImage("images/hyyh2.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().hyyh2AlbumName,
                                songNames: AlbumData().hyyh2AlbumSongs,
                                albumArt: AlbumData().hyyh2Art,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "The most beautiful moment in life pt.2",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// young forever
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
                            image: const DecorationImage(image: AssetImage("images/youngforever.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().youngForeverAlbumName,
                                songNames: AlbumData().youngForeverAlbumSongs,
                                albumArt: AlbumData().youngForeverArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "The most beautiful moment in life :\nYoung Forever",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// wings
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
                            image: const DecorationImage(image: AssetImage("images/wings.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().wingsAlbumName,
                                songNames: AlbumData().wingsAlbumSongs,
                                albumArt: AlbumData().wingsArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "Wings",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// ynwa
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
                            image: const DecorationImage(image: AssetImage("images/ynwa.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().ynwaAlbumName,
                                songNames: AlbumData().ynwaAlbumSongs,
                                albumArt: AlbumData().ynwaArt,
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
                        "You Never Walk Alone",
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
              /// ly her
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
                            image: const DecorationImage(image: AssetImage("images/lyher.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().lyHerAlbumName,
                                songNames: AlbumData().lyHerAlbumSongs,
                                albumArt: AlbumData().lyHerArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "Love Yourself ???\n'HER'",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// ly tear
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
                            image: const DecorationImage(image: AssetImage("images/lytear.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().lyTearAlbumName,
                                songNames: AlbumData().lyTearAlbumSongs,
                                albumArt: AlbumData().lyTearArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "Love Yourself ???\n'TEAR'",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// ly answer
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
                            image: const DecorationImage(image: AssetImage("images/lyanswer.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().lyAnswerAlbumName,
                                songNames: AlbumData().lyAnswerAlbumSongs,
                                albumArt: AlbumData().lyAnswerArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "Love Yourself ??? 'ANSWER'",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// mots persona
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
                            image: const DecorationImage(image: AssetImage("images/motspersona.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().motsPersonaAlbumName,
                                songNames: AlbumData().motsPersonaAlbumSongs,
                                albumArt: AlbumData().motsPersonaArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "Map Of The Soul : PERSONA",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// mots 7
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
                            image: const DecorationImage(image: AssetImage("images/mots7.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().mots7AlbumName,
                                songNames: AlbumData().mots7AlbumSongs,
                                albumArt: AlbumData().mots7Art,
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
                        "Map Of The Soul : 7",
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
              /// be
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
                            image: const DecorationImage(image: AssetImage("images/be.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().beAlbumName,
                                songNames: AlbumData().beAlbumSongs,
                                albumArt: AlbumData().beArt,
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
                        "BE",
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
              /// butter and ptd
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
                            image: const DecorationImage(image: AssetImage("images/butter-ptd.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName: AlbumData().butterPtdAlbumName,
                                songNames: AlbumData().butterPtdAlbumSongs,
                                albumArt: AlbumData().butterPtdArt,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    "Butter / Permission\nto Dance",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              /// butter and ptd
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
                            image: const DecorationImage(image: AssetImage("images/proof.jpg"), fit: BoxFit.fill)
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
                  const SizedBox(height: 4),
                  Text(
                    "Proof",
                    textAlign: TextAlign.center,
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
      ),
    );
  }
}
