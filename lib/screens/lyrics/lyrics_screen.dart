import 'dart:developer';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class LyricsPage extends StatefulWidget {
  final Lyrics songLyrics;
  final String songName, songFullName;

  const LyricsPage({super.key, required this.songLyrics, required this.songName, required this.songFullName});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  late Box userFavLyricsBox;
  List userFavLyrics = [];
  bool isFav = false;

  loadData() async {
    userFavLyricsBox = await Hive.openBox('userFavourites');
    userFavLyrics = userFavLyricsBox.get('favouritesList', defaultValue: []);
    if (userFavLyrics.contains(widget.songFullName)) {
      setState(() {
        isFav = true;
      });
    }
    log("load favList: $userFavLyrics");
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
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: true,
                  forceElevated: true,
                  bottom: PreferredSize(
                    preferredSize: const Size(0, kToolbarHeight),
                    child: TabBar(
                      indicatorColor: Theme.of(context).indicatorColor,
                      tabs: [
                        if (widget.songLyrics.kr != null) const Tab(text: "KOR"),
                        if (widget.songLyrics.jp != null) const Tab(text: "JP"),
                        const Tab(text: "ENG"),
                        if(widget.songLyrics.kr != null || widget.songLyrics.jp != null)
                          const Tab(text: "ROM",)
                      ],
                    ),
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
                  elevation: 0,
                  title: Text(
                    "Lyrics",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                  ),
                  actions: [
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
                        log("current favList: $userFavLyrics");
                      },
                      icon: Icon(isFav ? Icons.favorite : Icons.favorite_outline),
                      tooltip: "Add to favorites",
                    )
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