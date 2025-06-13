import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/home/main.dart';
import 'package:bts_lyrics_app/services/settings_service.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class LyricsPage extends StatefulWidget {
  final Lyrics songLyrics;
  final String songName, songFullName;
  final SongLink songLink;

  const LyricsPage({super.key, required this.songLyrics, required this.songName, required this.songFullName, required this.songLink});

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.songLyrics.kr != null || widget.songLyrics.jp != null ? 3 : 1,
      child: Scaffold(
        backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
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
                    tabs: [
                      if (widget.songLyrics.kr != null) const Tab(text: "KOR"),
                      if (widget.songLyrics.jp != null) const Tab(text: "JP"),
                      const Tab(text: "ENG"),
                      if(widget.songLyrics.kr != null || widget.songLyrics.jp != null)
                        const Tab(text: "ROM",)
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  if (widget.songLyrics.kr != null)
                    buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.kr),
                  if (widget.songLyrics.jp != null)
                    buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.jp),
                  buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.eng),
                  if(widget.songLyrics.kr != null || widget.songLyrics.jp != null)
                    buildTabContent(context: context, name: widget.songName, lyrics: widget.songLyrics.rom),
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
                    const SizedBox(width: 6),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}