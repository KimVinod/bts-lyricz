import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:bts_lyrics_app/screens/songs/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSongCard extends StatelessWidget {
  final Song song;
  const CustomSongCard({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Material(
              elevation: 3,
              shadowColor: Colors.purple.shade700,
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                width: 150,
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(image: AssetImage(song.albumArt), fit: BoxFit.fill)
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if(song.album == null) {
                      switch(song.lang) {
                        case "eng":
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsENG(
                            songFullName: song.name,
                            songName: song.displayName,
                            songTabs: const [1,0,0,0],
                            songLyrics: song.lyrics,
                          )));
                          break;
                        case "kr":
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsKR(
                            songFullName: song.name,
                            songName: song.displayName,
                            songTabs: const [1,1,1,0],
                            songLyrics: song.lyrics,
                          )));
                          break;
                        case "jp":
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsJP(
                            songFullName: song.name,
                            songName: song.displayName,
                            songTabs: const [1,1,0,1],
                            songLyrics: song.lyrics,
                          )));
                          break;
                      }
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Songs(albumName: song.album!, albumArt: song.albumArt)));
                    }

                  },
                ),
              )),
          const SizedBox(height: 6),
          SizedBox(
            height: 20,
            width: 150,
            child: FittedBox(
              child: Text(
                song.displayName,
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
    );
  }
}