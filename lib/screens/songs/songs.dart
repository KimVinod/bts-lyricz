import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class Songs extends StatefulWidget {
  final String albumName;
  final String albumArt;

  const Songs({Key? key, required this.albumName, required this.albumArt}) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  List<Song> songs = [];

  void loadSongs() {
    setState(() {
      songs = allSongs.where((s) => s.album == widget.albumName).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text("Songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        titleSpacing: 0,
        backgroundColor: appBarColor,
      ),
      body: Material(
        color: appUILightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 15),
            Center(
              child: Column(
                children: <Widget>[
                  Material(
                      elevation: 3,
                      shadowColor: Colors.purple.shade700,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 150,
                        height: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage(widget.albumArt), fit: BoxFit.fill)
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    widget.albumName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Songs",
                style: GoogleFonts.openSans(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Card(
                    elevation: 3,
                    shadowColor: Colors.purple.shade700,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: const Color.fromRGBO(152, 105, 190, 1),
                    child: RawScrollbar(
                      thumbColor: const Color.fromRGBO(130, 70, 190, 1),
                      thickness: 5.0,
                      radius: const Radius.circular(15.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                            color: Colors.black, height: 1, thickness: 0.6),
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            title: Text(
                              songs[index].name,
                              style: GoogleFonts.openSans(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              switch(songs[index].lang) {
                                case "eng":
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsENG(
                                    songFullName: songs[index].name,
                                    songName: songs[index].displayName,
                                    songTabs: const [1,0,0,0],
                                    songLyrics: songs[index].lyrics,
                                  )));
                                  break;
                                case "kr":
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsKR(
                                    songFullName: songs[index].name,
                                    songName: songs[index].displayName,
                                    songTabs: const [1,1,1,0],
                                    songLyrics: songs[index].lyrics,
                                  )));
                                  break;
                                case "jp":
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsJP(
                                    songFullName: songs[index].name,
                                    songName: songs[index].displayName,
                                    songTabs: const [1,1,0,1],
                                    songLyrics: songs[index].lyrics,
                                  )));
                                  break;

                              }
                            },
                          );
                        },
                      ),
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
