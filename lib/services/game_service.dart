import 'dart:math';
import 'package:bts_lyrics_app/data/song_model.dart';

class GameService {
  static final Random _random = Random();

  static List<Song> filterSongs(List<Song> songs) {
    return songs.where((song) => song.lyrics.eng != null).toList();
  }

  static Lyrics getRandomLyrics(Lyrics lyrics, int numLines) {
    try {
      if (lyrics.eng != null) {
        String engLyrics = lyrics.eng!;
        List<String> lines = engLyrics.split('\n').where((line) => line.trim().isNotEmpty && !line.startsWith('[')).toList();

        if (lines.length < numLines) {
          return getRandomLyrics(lyrics, numLines);
        }

        int maxStartIndex = lines.length - (numLines - 1);
        int startIndex = _random.nextInt(maxStartIndex);
        List<String> selectedLines = lines.sublist(startIndex, startIndex + numLines);

        if (selectedLines.length < numLines || selectedLines.any((line) => line.trim().isEmpty)) {
          return getRandomLyrics(lyrics, numLines);
        }

        String selectedLyrics = selectedLines.join('\n');

        return Lyrics(eng: selectedLyrics);
      } else {
        return const Lyrics();
      }
    } catch (e) {
      return getRandomLyrics(lyrics, numLines);
    }
  }
}
