import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/screens/search/search_songs.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_card_with_title.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_card_without_title.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_song_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  final ScrollController controller;

  const HomeTab({super.key, required this.controller});

  //final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    /*Timer(
        const Duration(seconds: 1),
            () {
            if (controller.hasClients) {
              controller.animateTo(controller.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
            }
        }
    );*/

    return Scaffold(
      backgroundColor: appUILightColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 56,
              color: appUILightColor,
              width: MediaQuery.of(context).size.width,
              child: Material(
                color: appUILightColor,
                elevation: 3,
                child: Stack(
                  children: [
                    Align(
                      child: Text(
                        "Bangtan Lyricz",
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.black),
                        tooltip: "Search",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchSongs()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "New Releases",
                              style: GoogleFonts.openSans(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            height: 196,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 16, right: 6),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: newReleaseSongs.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomSongCard(song: newReleaseSongs[index]),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0), // space above albums
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "Discography",
                              style: GoogleFonts.openSans(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(left:16 ,right: 6),
                              scrollDirection: Axis.horizontal,
                              itemCount: discography.length,
                              itemBuilder: (context, index) {
                                final imageAsset = discography.keys.elementAt(index);
                                final widget = discography.values.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CustomCardWithoutTitle(imageAsset: imageAsset, widget: widget),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 14.0), // space above solo
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "Solo Projects",
                              style: GoogleFonts.openSans(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0), //space below solo
                          SizedBox(
                            height: 196,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(left:16 ,right: 6),
                              scrollDirection: Axis.horizontal,
                              itemCount: soloProjects.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CustomCardWithTitle(name: soloProjects[index]['name'], imageAsset: soloProjects[index]['imageAsset'], widget: soloProjects[index]['widget']),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
