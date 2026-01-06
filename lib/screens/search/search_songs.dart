import 'package:bts_lyricz/data/song_model.dart';
import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:bts_lyricz/utils/widgets/custom_song_mini_card.dart';
import 'package:bts_lyricz/utils/widgets/search_widget.dart';
import 'package:bts_lyricz/data/song_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSongs extends StatefulWidget {
  const SearchSongs({super.key});

  @override
  SearchSongsState createState() => SearchSongsState();
}

class SearchSongsState extends State<SearchSongs> {
  List<Song> songs = [];
  String query = "";
  late String bt21Asset;

  @override
  void initState() {
    super.initState();
    bt21Asset = getBt21Pic();
    loadSongs();
  }

  void loadSongs() {
    final seen = <String>{};
    List<Song> uniqueList = allSongs.where((e) => seen.add(e.name)).toList();
    uniqueList.sort((s1, s2) => s1.name.compareTo(s2.name));
    songs = uniqueList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        top: false,
        child: NestedScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: true,
              titleSpacing: 0,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28))),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text("Search Songs", style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w600)),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight + 32),
                child: SearchWidget(
                  text: query,
                  onChanged: searchSongs,
                  hintText: 'Search by song name, lyrics or album...',
                ),
              ),
            ),
          ],
          body: Column(
            mainAxisAlignment: songs.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              if(songs.isEmpty)...[
                GestureDetector(
                  onTap: ()=> setState(() {}),
                  child: Image.asset(bt21Asset, height: MediaQuery.sizeOf(context).height * 0.25),
                ),
                const SizedBox(height: 10),
                Text("Nothing here  ~.~", style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic)),
              ] else ...[
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16),
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
              ]

            ],
          ),
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
      final albumName = song.album?.replaceAll(RegExp(r"['’]"), "").toLowerCase() ?? '';
      final searchLower = query.replaceAll(RegExp(r"['’]"), "").toLowerCase();
      final lowercaseEngLyrics = song.lyrics.eng?.toLowerCase() ?? '';
      final lowercaseJpLyrics = song.lyrics.jp?.toLowerCase() ?? '';
      final lowercaseKrLyrics = song.lyrics.kr?.toLowerCase() ?? '';

      return songName.contains(searchLower) ||
          albumName.contains(searchLower) ||
          lowercaseEngLyrics.contains(searchLower) ||
          lowercaseJpLyrics.contains(searchLower) ||
          lowercaseKrLyrics.contains(searchLower);
    }).toList();

    matchedSongs.sort((a, b) {
      final songNameA = a.name.toLowerCase();
      final songNameB = b.name.toLowerCase();
      final albumNameA = a.album?.toLowerCase() ?? '';
      final albumNameB = b.album?.toLowerCase() ?? '';
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

      // Add the comparison for album names
      final containsQueryAlbumA = albumNameA.contains(query);
      final containsQueryAlbumB = albumNameB.contains(query);

      if (containsQueryAlbumA && !containsQueryAlbumB) {
        return -1; // albumNameA should come before albumNameB
      } else if (!containsQueryAlbumA && containsQueryAlbumB) {
        return 1; // albumNameA should come after albumNameB
      }

      // If neither song names nor lyrics nor album names match the query, maintain the original order
      return 0;
    });

    setState(() {
      this.query = query;
      songs = matchedSongs;
    });
  }

}
