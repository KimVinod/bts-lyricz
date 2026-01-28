import 'package:bts_lyricz/data/song_model.dart';
import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/screens/share/song_lyrics_generator.dart';
import 'package:bts_lyricz/services/settings_service.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class LyricsPage extends StatefulWidget {
  final Lyrics songLyrics;
  final String songName, songFullName, releaseDate, songArtistName, songAlbumArt;
  final SongLink songLink;

  const LyricsPage({super.key, required this.songLyrics, required this.songName, required this.songFullName, required this.songLink, required this.releaseDate, required this.songArtistName, required this.songAlbumArt});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  late Box userFavLyricsBox;
  List userFavLyrics = [];
  bool isFav = false;

  void loadData() async {
    userFavLyricsBox = await Hive.openBox('userFavourites');
    userFavLyrics = userFavLyricsBox.get('favouritesList', defaultValue: []);
    if (userFavLyrics.contains(widget.songFullName)) {
      setState(() {
        isFav = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void openBangtanCardGenerator(String? lyrics) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SongLyricsGenerator(
      songTitle: widget.songFullName,
      artistName: widget.songArtistName,
      albumArt: AssetImage(widget.songAlbumArt),
      lyrics: lyrics ?? "",
      mode: (lyrics != null && lyrics.isNotEmpty) ? GenerationMode.lyrics : GenerationMode.song,
    )));
  }

  void _showLyricsSelection() {

    void onTap(String lyric) {
      switch(lyric) {
        case "KOR":
          openBangtanCardGenerator(widget.songLyrics.kr);
          break;
        case "JP":
          openBangtanCardGenerator(widget.songLyrics.jp);
          break;
        case "ENG":
          openBangtanCardGenerator(widget.songLyrics.eng);
          break;
        case "ROM":
          openBangtanCardGenerator(widget.songLyrics.rom);
          break;
        default:
          openBangtanCardGenerator("");
          break;
      }
    }

    final List<String> listOfLyrics = getListOfLyrics();

    if(listOfLyrics.isEmpty) return;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Select language", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),),
            const SizedBox(height: 20),
            ...listOfLyrics.map((lyric) => ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(lyric),
              onTap: () {
                Navigator.pop(ctx); // Close Sheet
                onTap(lyric);
              },
            )),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text("Skip lyrics"),
              onTap: () {
                Navigator.pop(ctx); // Close Sheet
                onTap("");
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getListOfLyrics() {
    final List<String> listOfLyrics = [];

    if (widget.songLyrics.kr != null) listOfLyrics.add("KOR");
    if (widget.songLyrics.jp != null) listOfLyrics.add("JP");
    if (widget.songLyrics.eng != null) listOfLyrics.add("ENG");
    if(widget.songLyrics.kr != null || widget.songLyrics.jp != null) listOfLyrics.add("ROM");

    return listOfLyrics;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: getListOfLyrics().length,
      child: Scaffold(
        backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              NestedScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    pinned: true,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    bottom: TabBar(
                      dividerColor: Colors.transparent,
                      tabs: getListOfLyrics().map((lyric) => Tab(text: lyric)).toList(),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    if (widget.songLyrics.kr != null) buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.kr, releaseDate: widget.releaseDate),
                    if (widget.songLyrics.jp != null) buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.jp, releaseDate: widget.releaseDate),
                    if (widget.songLyrics.eng != null) buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.eng, releaseDate: widget.releaseDate),
                    if (widget.songLyrics.kr != null || widget.songLyrics.jp != null) buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.rom, releaseDate: widget.releaseDate),
                  ],
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: AppBar(
                    titleSpacing: 0,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    title: Text(
                      "Lyrics",
                      style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => SettingsService.playSong(widget.songLink.spotify ?? widget.songLink.soundcloud ?? widget.songLink.youtube!),
                        icon: FaIcon(widget.songLink.spotify != null ? FontAwesomeIcons.spotify : widget.songLink.soundcloud != null ? FontAwesomeIcons.soundcloud : FontAwesomeIcons.youtube),
                        tooltip: widget.songLink.spotify != null ? "Play on Spotify" : widget.songLink.soundcloud != null ? "Play on SoundCloud" : "Play on YouTube",
                      ),
                      IconButton(
                        onPressed: () {
                          if (userFavLyrics.contains(widget.songFullName)) {
                            userFavLyrics.remove(widget.songFullName);
                            setState(() {
                              isFav = false;
                            });
                          } else {
                            userFavLyrics.add(widget.songFullName);
                            setState(() {
                              isFav = true;
                            });
                          }
                          userFavLyricsBox.put("favouritesList", userFavLyrics);
                        },
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_outline),
                        tooltip: "Add to favorites",
                      ),
                      IconButton(
                        onPressed: _showLyricsSelection,
                        icon: Icon(Icons.share),
                        tooltip: "Share",
                      ),
                      const SizedBox(width: 6),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}