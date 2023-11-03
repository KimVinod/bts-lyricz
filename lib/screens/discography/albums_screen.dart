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
    double childAspectRatio = 1;
    String title = "";

    switch (type) {
      case 'kr':
        title = "BTS Korean Albums";
        albums = krAlbums;
        childAspectRatio = 0.72;
        break;

      case 'jp':
        title = "BTS Japanese Albums";
        albums = jpAlbums;
        childAspectRatio = 0.77;
        break;

      case 'uo':
        title = "BTS Unofficial Albums";
        albums = uoAlbums;
        childAspectRatio = 0.72;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.surface,
        child: AnimationLimiter(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: childAspectRatio),
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
      ),
    );
  }
}
