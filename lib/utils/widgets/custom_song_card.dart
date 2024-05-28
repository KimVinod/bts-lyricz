import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_screen.dart';
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
      onTap: () => onTap(context),
      child: Column(
        children: <Widget>[
          Material(
              elevation: 3,
              shadowColor: Theme.of(context).colorScheme.shadow,
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(image: AssetImage(song.albumArt), fit: BoxFit.fill)
                ),
                child: InkWell(
                  overlayColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => onTap(context),
                ),
              )),
          const SizedBox(height: 6),
          SizedBox(
            height: 20,
            width: 170,
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

  void onTap(BuildContext context) {
    if(song.album == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsPage(
        songFullName: song.name,
        songName: song.displayName,
        songLyrics: song.lyrics,
        songLink: song.songLink,
      )));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Songs(albumName: song.album!, albumArt: song.albumArt)));
    }
  }
}