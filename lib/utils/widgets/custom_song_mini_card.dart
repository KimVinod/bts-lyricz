import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSongMiniCard extends StatelessWidget {
  final Song song;
  final VoidCallback onFinish;
  const CustomSongMiniCard({super.key,required this.song, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 3,
        color: Colors.transparent,
        shadowColor: Theme.of(context).colorScheme.shadow,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: <Widget>[
              Container(
                height: 85,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 85,
                      height: 85,
                      child: Image.asset(song.albumArt),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        song.name,
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsPage(
                      songFullName: song.name,
                      songName: song.displayName,
                      songLyrics: song.lyrics,
                      songLink: song.songLink,
                    ))).then((value) => onFinish()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}