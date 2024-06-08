import 'package:bts_lyrics_app/screens/home/main.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_album_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class Albums extends StatelessWidget {
  final String type;
  const Albums({super.key, required this.type});

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> albums = [];
    String title = "";

    switch (type) {
      case 'kr':
        title = "BTS Korean Albums";
        albums = krAlbums;
        break;

      case 'jp':
        title = "BTS Japanese Albums";
        albums = jpAlbums;
        break;

      case 'uo':
        title = "BTS Unofficial Albums";
        albums = uoAlbums;
        break;
    }

    return Scaffold(
      backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
      ),
      body: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 196, mainAxisExtent: 196, mainAxisSpacing: 24, crossAxisSpacing: 16),
          itemCount: albums.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            duration: const Duration(milliseconds: 500),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: CustomAlbumCard(albumName: albums[index]['album'], imageAsset: albums[index]['imageAsset']),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
