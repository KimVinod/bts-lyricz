import 'package:bts_lyricz/data/song_model.dart';
import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/services/firebase_service.dart';
import 'package:bts_lyricz/utils/debouncer.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:bts_lyricz/utils/widgets/custom_song_mini_card.dart';
import 'package:bts_lyricz/utils/widgets/search_widget.dart';
import 'package:bts_lyricz/data/song_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

List<SearchableSong> processSongsInBackground(List<Song> rawSongs) {
  final RegExp symbolRegex = RegExp(removeSymbolsRegexString);

  String clean(String text) {
    if (text.isEmpty) return "";
    return text.toLowerCase().replaceAll(symbolRegex, "").trim();
  }

  // Filter unique songs
  final seen = <String>{};
  List<Song> uniqueSongs = rawSongs.where((e) => seen.add(e.name)).toList();

  // Sort alphabetically
  uniqueSongs.sort((s1, s2) => s1.name.compareTo(s2.name));

  // Map to SearchableSong
  return uniqueSongs.map((song) {
    final fullLyrics = "${song.lyrics.eng ?? ''} ${song.lyrics.jp ?? ''} ${song.lyrics.kr ?? ''}";

    return SearchableSong(
      song: song,
      cleanName: clean(song.name),
      cleanAlbum: clean(song.album ?? ''),
      cleanLyrics: clean(fullLyrics),
    );
  }).toList();
}

class SearchSongs extends StatefulWidget {
  const SearchSongs({super.key});

  @override
  SearchSongsState createState() => SearchSongsState();
}

class SearchSongsState extends State<SearchSongs> {
  List<Song> displayedSongs = [];
  List<SearchableSong> _searchableData = [];
  String query = "";
  late String bt21Asset;
  final _debouncer = Debouncer(milliseconds: 250);
  final RegExp _symbolRegex = RegExp(removeSymbolsRegexString);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    bt21Asset = getBt21Pic();
    _loadSongs();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  String _cleanInput(String text) => text.toLowerCase().replaceAll(_symbolRegex, "").trim();

  Future<void> _loadSongs() async {
    try {
      final processedData = await compute(processSongsInBackground, allSongs);

      // Check if user left the screen before calculation finished
      if (!mounted) return;

      setState(() {
        _searchableData = processedData;
        // Initial display is just the raw list of songs
        displayedSongs = processedData.map((e) => e.song).toList();
        _isLoading = false;
      });
    } catch(e, s) {
      FirebaseService.logCustomError(e, s, "SearchSongsState - _loadSongs");
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        displayedSongs = [];
      });
    }
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
                  onChanged: (value) => _debouncer.run(() => searchSongs(value)),
                  hintText: 'Search by song name, lyrics or album...',
                ),
              ),
            ),
          ],
          body: _isLoading
              ? SizedBox()
              : Column(
            mainAxisAlignment: displayedSongs.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              if(displayedSongs.isEmpty)...[
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
                      key: ValueKey(query),
                      padding: const EdgeInsets.only(top: 16),
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayedSongs.length,
                      itemBuilder: (context, index) {
                        final song = displayedSongs[index];
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

  void searchSongs(String rawQuery) {
    if (_isLoading) return;

    if (rawQuery.isEmpty) {
      setState(() {
        query = rawQuery;
        displayedSongs = _searchableData.map((e) => e.song).toList();
      });
      return;
    }

    final cleanQuery = _cleanInput(rawQuery);

    // 1. Create a temporary list of matches with a 'rank' score
    final List<({Song song, int rank})> rankedMatches = [];

    for (var item in _searchableData) {
      int rank = -1;

      // Check priority and assign a rank (Higher number = better match)
      if (item.cleanName == cleanQuery) {
        rank = 4; // Exact name match (Best)
      } else if (item.cleanName.contains(cleanQuery)) {
        rank = 3; // Name contains query
      } else if (item.cleanAlbum.contains(cleanQuery)) {
        rank = 2; // Album contains query
      } else if (cleanQuery.length >= 3 && item.cleanLyrics.contains(cleanQuery)) { // check lyrics only if query length >= 3 to avoid increase in cpu usage
        rank = 1; // Lyrics contains query
      }

      // If it matches anything, add it to the results
      if (rank != -1) {
        rankedMatches.add((song: item.song, rank: rank));
      }
    }

    // 2. Sort the list based on the RANK
    rankedMatches.sort((a, b) {
      // Sort by rank descending (4 comes before 3)
      int res = b.rank.compareTo(a.rank);
      if (res != 0) return res;

      // Fallback: If ranks are equal, sort alphabetically by name
      return a.song.name.compareTo(b.song.name);
    });

    setState(() {
      query = rawQuery;
      displayedSongs = rankedMatches.map((e) => e.song).toList();
    });
  }

}
