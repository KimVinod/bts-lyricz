import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/home/main.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_album_card.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_song_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class Member extends StatefulWidget {
  final String memberName, dataKey;
  const Member({super.key, required this.memberName, required this.dataKey});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {

  List<Song> songs = [];
  List<Map<String, dynamic>> albums = [];

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  void loadSongs() {
    songs = allSongs.where((s) => s.isSolo.isSolo && s.isSolo.soloName == widget.dataKey && s.album == null).toList();

    List<Song> albumSongs = allSongs
        .where((s) => s.isSolo.isSolo && s.isSolo.soloName == widget.dataKey && s.album != null)
        .toList();

    Set<String> uniqueAlbumNames = {};

    for (Song song in albumSongs) {
      if (!uniqueAlbumNames.contains(song.album!)) {
        uniqueAlbumNames.add(song.album!);
        albums.add({
          'albumName': song.album!,
          'imageAsset': song.albumArt,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("${widget.memberName} Albums and Songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Albums",
                style: GoogleFonts.openSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 198,
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16.0, right: 6.0),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: albums.length,
                  itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      horizontalOffset: 50,
                      child: FadeInAnimation(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: CustomAlbumCard(albumName: albums[index]['albumName'], imageAsset: albums[index]['imageAsset']),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
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
                thumbColor: Theme.of(context).focusColor,
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
                              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                              child: CustomSongMiniCard(song: song, onFinish: () {}),
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
