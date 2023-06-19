import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class SongsUO extends StatefulWidget {
  const SongsUO({Key? key}) : super(key: key);

  @override
  State<SongsUO> createState() => _SongsUOState();
}

class _SongsUOState extends State<SongsUO> {

  List<Song> songs = [];

  void loadSongs() {
    setState(() {
      songs = allSongs.where((s) => s.isSolo.isSolo == true && s.isSolo.isUnofficial == true).toList();
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
        
        titleSpacing: 0,
        title: Text("BTS Unofficial Songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        backgroundColor: appBarColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: appUILightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Songs",
                style: GoogleFonts.openSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: RawScrollbar(
                thumbVisibility: true,
                thumbColor: appThumbBarColor,
                thickness: 7.0,
                radius: const Radius.circular(15.0),
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 20, left: 16, right: 16),
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 85,
                                      height: 85,
                                      child: Image.asset(song.albumArt),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        song.name,
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
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsPage(
                                      songFullName: song.name,
                                      songName: song.displayName,
                                      songLyrics: song.lyrics,
                                    ))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
