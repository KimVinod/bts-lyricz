import 'package:bts_lyricz/data/song_data.dart';
import 'package:bts_lyricz/data/song_model.dart';
import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/utils/widgets/custom_song_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalSingles extends StatefulWidget {
  final bool isUnOfficial, isArmy;
  const DigitalSingles({super.key, required this.isUnOfficial, required this.isArmy});

  @override
  State<DigitalSingles> createState() => _DigitalSinglesState();
}

class _DigitalSinglesState extends State<DigitalSingles> {

  List<Song> songs = [];

  void loadSongs() {
    if(widget.isUnOfficial) {
      if(widget.isArmy) {
        songs = allSongs.where((s) => s.isArmy == true).toList();
      } else {
        songs = allSongs.where((s) => s.isSolo.isSolo == true && s.isSolo.isUnofficial == true).toList();
      }
    } else {
      songs = allSongs.where((s) => s.isSolo.isSolo == true && s.isSolo.soloName == "bts").toList();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(widget.isUnOfficial ? widget.isArmy ? "ARMY Songs" : "BTS Unofficial Songs" : "BTS Digital Singles", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
      ),
      body: RawScrollbar(
        thumbColor: Theme.of(context).focusColor,
        thickness: 7.0,
        radius: const Radius.circular(15.0),
        thumbVisibility: true,
        child: AnimationLimiter(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 16, left: 16, right: 16),
                      child: CustomSongMiniCard(song: song, onFinish: () {}),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
