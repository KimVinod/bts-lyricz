import 'package:bts_lyrics_app/albumdata.dart';
import 'package:bts_lyrics_app/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumsUO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "BTS Unofficial Albums";
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Color.fromRGBO(150, 86, 190, 1),
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
      ),
      body: Container(
        width: double.infinity,
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
                crossAxisCount: 2, childAspectRatio: 0.73),
            children: <Widget>[
              /// bts world
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
                            image: DecorationImage(image: AssetImage("images/bts-world.jpg"), fit: BoxFit.fill)
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          //splashColor: Colors.purple.shade200.withOpacity(0.5),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Songs(
                                albumName:
                                AlbumData().btsWorldAlbumName,
                                songNames: AlbumData().btsWorldAlbumSongs,
                                albumArt: AlbumData().btsWorldArt,
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
                        "BTS World",
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
