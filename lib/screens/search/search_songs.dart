import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:bts_lyrics_app/screens/search/search_widget.dart';
import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleSpacing: 0,
        title: Text("Search songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        backgroundColor: appBarColor,

      ),
      body: Material(
        color: appUILightColor,
        child: Column(
          children: [
            buildSearch(),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll){
                overScroll.disallowIndicator();
                return true;
              },
              child: Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        color: Colors.transparent,
                        shadowColor: Colors.purple.shade700,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(152, 105, 190, 1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: <Widget>[
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        song.name,
                                        style: GoogleFonts.openSans(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
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
                                    },
                                  ),
                                ),
                              )
                            ],
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

  Widget buildSearch() => SearchWidget(
    text: query,
    onChanged: searchSongs,
    hintText: 'Search here',
  );

  void searchSongs(String query) {

    final seen = <String>{};
    List<Song> uniqueList = allSongs.where((e) => seen.add(e.name)).toList();
    uniqueList.sort((s1, s2) => s1.name.compareTo(s2.name));

    final songs = uniqueList.where((song) {
      final songName = song.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return songName.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.songs = songs;
    });
  }
}
