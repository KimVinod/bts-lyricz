import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_song_mini_card.dart';
import 'package:bts_lyrics_app/utils/widgets/search_widget.dart';
import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSongs extends StatefulWidget {
  const SearchSongs({Key? key}) : super(key: key);

  @override
  SearchSongsState createState() => SearchSongsState();
}

class SearchSongsState extends State<SearchSongs> {
  List<Song> songs = [];
  String query = "";

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  void loadSongs() {
    final seen = <String>{};
    List<Song> uniqueList = allSongs.where((e) => seen.add(e.name)).toList();
    uniqueList.sort((s1, s2) => s1.name.compareTo(s2.name));
    setState(() {
      songs = uniqueList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text("Search songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            SearchWidget(
              text: query,
              onChanged: searchSongs,
              hintText: 'Search by song name or lyrics...',
            ),
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                            child: CustomSongMiniCard(song: song, onFinish: () {}),
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

  void searchSongs(String query) {
    final seen = <String>{};
    List<Song> uniqueList = allSongs.where((e) => seen.add(e.name)).toList();
    uniqueList.sort((s1, s2) => s1.name.compareTo(s2.name));

    final matchedSongs = query.isEmpty
        ? uniqueList // Show all songs if the query is empty
        : uniqueList.where((song) {
      final songName = song.name.replaceAll(RegExp(r"['’]"), "").toLowerCase();
      final searchLower = query.replaceAll(RegExp(r"['’]"), "").toLowerCase();
      final lowercaseEngLyrics = song.lyrics.eng?.toLowerCase() ?? '';
      final lowercaseJpLyrics = song.lyrics.jp?.toLowerCase() ?? '';
      final lowercaseKrLyrics = song.lyrics.kr?.toLowerCase() ?? '';

      return songName.contains(searchLower) ||
          lowercaseEngLyrics.contains(searchLower) ||
          lowercaseJpLyrics.contains(searchLower) ||
          lowercaseKrLyrics.contains(searchLower);
    }).toList();

    matchedSongs.sort((a, b) {
      final songNameA = a.name.toLowerCase();
      final songNameB = b.name.toLowerCase();
      final lowercaseEngLyricsA = a.lyrics.eng?.toLowerCase() ?? '';
      final lowercaseEngLyricsB = b.lyrics.eng?.toLowerCase() ?? '';
      final lowercaseJpLyricsA = a.lyrics.jp?.toLowerCase() ?? '';
      final lowercaseJpLyricsB = b.lyrics.jp?.toLowerCase() ?? '';
      final lowercaseKrLyricsA = a.lyrics.kr?.toLowerCase() ?? '';
      final lowercaseKrLyricsB = b.lyrics.kr?.toLowerCase() ?? '';

      // Check if there's an exact match in the song name
      final exactMatchA = songNameA == query.toLowerCase();
      final exactMatchB = songNameB == query.toLowerCase();

      // If there's an exact match in song name, it should come first
      if (exactMatchA && !exactMatchB) {
        return -1;
      } else if (!exactMatchA && exactMatchB) {
        return 1;
      }

      // Compare song names first
      if (songNameA.contains(query) && !songNameB.contains(query)) {
        return -1; // songNameA should come before songNameB
      } else if (!songNameA.contains(query) && songNameB.contains(query)) {
        return 1; // songNameA should come after songNameB
      }

      // If song names have equal priority or both don't match the query,
      // then compare the presence of the query in the lyrics
      final containsQueryLyricsA =
          lowercaseEngLyricsA.contains(query) ||
              lowercaseJpLyricsA.contains(query) ||
              lowercaseKrLyricsA.contains(query);
      final containsQueryLyricsB =
          lowercaseEngLyricsB.contains(query) ||
              lowercaseJpLyricsB.contains(query) ||
              lowercaseKrLyricsB.contains(query);

      if (containsQueryLyricsA && !containsQueryLyricsB) {
        return -1; // lowercaseEngLyricsA should come before lowercaseEngLyricsB
      } else if (!containsQueryLyricsA && containsQueryLyricsB) {
        return 1; // lowercaseEngLyricsA should come after lowercaseEngLyricsB
      }

      // If neither song names nor lyrics match the query, maintain the original order
      return 0;
    });

    setState(() {
      this.query = query;
      songs = matchedSongs;
    });
  }

}
