import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class GameLyricsCard extends StatelessWidget {
  const GameLyricsCard({
    super.key,
    required this.currentLyrics, required this.selectedLanguage,
  });

  final Lyrics currentLyrics;
  final String selectedLanguage;

  @override
  Widget build(BuildContext context) {
    String? lyrics;
    switch (selectedLanguage) {
      case 'eng':
        lyrics = currentLyrics.eng!;
        break;
      case 'kor':
        lyrics = currentLyrics.kr!;
        break;
      case 'jp':
        lyrics = currentLyrics.jp!;
        break;
    }

    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 500),
      child: FadeInAnimation(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 3,
          color: Colors.transparent,
          shadowColor: Theme.of(context).colorScheme.shadow,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Text(
                  lyrics!,
                  style: GoogleFonts.openSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}