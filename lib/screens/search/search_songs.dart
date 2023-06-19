import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_song_mini_card.dart';
import 'package:bts_lyrics_app/utils/widgets/search_widget.dart';
import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

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
        backgroundColor: appBarColor,
      ),
      body: Material(
        color: appUILightColor,
        child: Column(
          children: [
            SearchWidget(
              text: query,
              onChanged: searchSongs,
              hintText: 'Search by song or lyrics',
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
                            child: CustomSongMiniCard(song: song),
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

    final matchedSongs = uniqueList.where((song) {
      final songName = song.name.toLowerCase();
      final searchLower = query.toLowerCase();
      final lowercaseEngLyrics = song.lyrics.eng?.toLowerCase() ?? '';
      final lowercaseJpLyrics = song.lyrics.jp?.toLowerCase() ?? '';
      final lowercaseKrLyrics = song.lyrics.kr?.toLowerCase() ?? '';

      return songName.contains(searchLower) ||
          lowercaseEngLyrics.contains(searchLower) ||
          lowercaseJpLyrics.contains(searchLower) ||
          lowercaseKrLyrics.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      songs = matchedSongs;
    });
  }
}
