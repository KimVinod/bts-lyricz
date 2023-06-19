import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_song_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalSingles extends StatefulWidget {
  const DigitalSingles({Key? key}) : super(key: key);

  @override
  State<DigitalSingles> createState() => _DigitalSinglesState();
}

class _DigitalSinglesState extends State<DigitalSingles> {

  List<Song> songs = [];

  void loadSongs() {
    setState(() {
      songs = allSongs.where((s) => s.isSolo.isSolo == true && s.isSolo.soloName == "bts").toList();
    });
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
      appBar: AppBar(
        titleSpacing: 0,
        title: Text("BTS Digital Singles", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
        backgroundColor: appBarColor,
      ),
      body: Container(
        width: double.infinity,
        color: appUILightColor,
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Songs",
                style: GoogleFonts.openSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: RawScrollbar(
                thumbColor: appThumbBarColor,
                thickness: 7.0,
                radius: const Radius.circular(15.0),
                thumbVisibility: true,
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
                              padding: const EdgeInsets.only(top: 4, bottom: 16, left: 16, right: 16),
                              child: CustomSongMiniCard(song: song),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
