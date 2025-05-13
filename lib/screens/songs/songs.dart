import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/home/main.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class Songs extends StatefulWidget {
  final String albumName;
  final String albumArt;

  const Songs({super.key, required this.albumName, required this.albumArt});

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  List<Song> songs = [];
  Color appBarForegroundColor = Colors.white70;
  double averageLuminance = 0.5;
  final ScrollController _scrollController = ScrollController();

  void loadSongs() {
      songs = allSongs.where((s) => s.album == widget.albumName).toList();
  }

  Future<void> _calculateLuminance() async {
    final ByteData data = await rootBundle.load(widget.albumArt);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) return;

    final Uint8List rgbaBytes = byteData.buffer.asUint8List();
    double totalLuminance = 0.0;

    for (int i = 0; i < rgbaBytes.length; i += 4) {
      final int r = rgbaBytes[i];
      final int g = rgbaBytes[i + 1];
      final int b = rgbaBytes[i + 2];
      final luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255.0;
      totalLuminance += luminance;
    }

    setState(() {
      averageLuminance = totalLuminance / (image.width * image.height);
      appBarForegroundColor = averageLuminance > 0.5 ? Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).colorScheme.onSurface;
    });
  }

  void _onScroll() {
      final double offset = _scrollController.offset;
      if (offset > MediaQuery.sizeOf(context).height * 0.3) {
        if(appBarForegroundColor != Theme.of(context).colorScheme.onSurface) setState(() => appBarForegroundColor = Theme.of(context).colorScheme.onSurface);
      } else {
        //appBarForegroundColor = averageLuminance > 0.5 ? Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).colorScheme.onSurface;
        if (averageLuminance > 0.5) {
          if (Theme.of(context).brightness == Brightness.light) {
            if(appBarForegroundColor != Theme.of(context).colorScheme.onSurface) setState(() => appBarForegroundColor = Theme.of(context).colorScheme.onSurface);
          } else {
            if(appBarForegroundColor != Theme.of(context).colorScheme.onInverseSurface) setState(() => appBarForegroundColor = Theme.of(context).colorScheme.onInverseSurface);
          }
        } else {
          if (Theme.of(context).brightness == Brightness.light) {
            if(appBarForegroundColor != Theme.of(context).colorScheme.onInverseSurface) setState(() => appBarForegroundColor = Theme.of(context).colorScheme.onInverseSurface);
          } else {
            if(appBarForegroundColor != Theme.of(context).colorScheme.onSurface) setState(() => appBarForegroundColor = Theme.of(context).colorScheme.onSurface);
          }
        }
      }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _calculateLuminance();
    loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
      body: NestedScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height * 0.4,
            floating: true,
            pinned: true,
            snap: false,
            titleSpacing: 0,
            foregroundColor: appBarForegroundColor,
            title: Text("Album", style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.albumArt,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.37),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.albumName,
                        style: GoogleFonts.openSans(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Flexible(
                child: Card(
                  elevation: 3,
                  shadowColor: Theme.of(context).colorScheme.shadow,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  color: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.tertiaryContainer,
                  child: RawScrollbar(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    thumbColor: Theme.of(context).focusColor,
                    thickness: 5.0,
                    radius: const Radius.circular(15.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => Divider(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black38 : Colors.white30, height: 1, thickness: 0.6),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            songs[index].name,
                            style: GoogleFonts.openSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsPage(
                            songFullName: songs[index].name,
                            songName: songs[index].displayName,
                            songLyrics: songs[index].lyrics,
                            songLink: songs[index].songLink,
                          ))),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
