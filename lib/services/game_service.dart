import 'dart:math';
import 'package:bts_lyricz/data/song_model.dart';
import 'package:bts_lyricz/services/firebase_service.dart';

class GameService {
  static final Random _random = Random();

  static List<Song> filterSongs(List<Song> songs, String lang) {
    switch (lang) {
      case 'eng':
        return songs.where((song) => song.lyrics.eng != null).toList();
      case 'kor':
        return songs.where((song) => song.lyrics.kr != null).toList();
      case 'jp':
        return songs.where((song) => song.lyrics.jp != null).toList();
      default:
        return const <Song>[];
    }
  }

  static Lyrics getRandomLyrics(Lyrics lyrics, int numLines, String lang, int count) {
    try {
      String? selectedLyrics;

      switch (lang) {
        case 'eng':
          selectedLyrics = lyrics.eng;
          break;
        case 'kor':
          selectedLyrics = lyrics.kr;
          break;
        case 'jp':
          selectedLyrics = lyrics.jp;
          break;
        default:
          return const Lyrics();
      }

      List<String> lines = selectedLyrics?.split('\n').where((line) => line.trim().isNotEmpty && !line.startsWith('[')).toList() ?? [];

      if (lines.length < numLines) {
        return getRandomLyrics(lyrics, numLines - 1, lang, count);
      }

      int maxStartIndex = lines.length - (numLines - 1);
      int startIndex = _random.nextInt(maxStartIndex);
      List<String> selectedLines = lines.sublist(startIndex, startIndex + numLines);
      if (selectedLines.length < numLines || selectedLines.any((line) => line.trim().isEmpty) || (lang == 'kor' || lang == 'jp') && !containsMaxEnglishLines(selectedLines, 2)) {
        count--;
        if(count == 0) return const Lyrics(eng: "error");
        return getRandomLyrics(lyrics, numLines, lang, count);
      }
      String finalLyrics = selectedLines.join('\n');
      return Lyrics(
        eng: lang == 'eng' ? finalLyrics : null,
        kr: lang == 'kor' ? finalLyrics : null,
        jp: lang == 'jp' ? finalLyrics : null,
      );

    } catch (e, s) {
      FirebaseService.logCustomError(e, s, "GameService - getRandomLyrics");
      return const Lyrics(eng: "error");
    }
  }

  static bool containsMaxEnglishLines(List<String> lines, int maxLines) {
    // Check if the number of lines containing English words is less than or equal to maxLines
    int count = 0;
    for (var line in lines) {
      if (RegExp(r'[a-zA-Z]').hasMatch(line)) {
        count++;
        if (count > maxLines) {
          return false;
        }
      }
    }
    return true;
  }
}
