import 'package:bts_lyricz/data/song_data.dart';
import 'package:bts_lyricz/screens/search/search_songs.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:bts_lyricz/utils/widgets/custom_card.dart';
import 'package:bts_lyricz/utils/widgets/custom_song_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text("Bangtan Lyricz", style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: "Search",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchSongs()));
              },
            ),
          ],
        ),
      ],
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
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
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 196,
                child: AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 6),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: newReleaseSongs.length,
                    itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: CustomSongCard(song: newReleaseSongs[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0), // space above albums
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Discography",
                  style: GoogleFonts.openSans(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 180,
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left:16 ,right: 6),
                    scrollDirection: Axis.horizontal,
                    itemCount: discography.length,
                    itemBuilder: (context, index) {
                      final imageAsset = discography.keys.elementAt(index);
                      final widget = discography.values.elementAt(index);
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: 50,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: CustomCard(imageAsset: imageAsset, widget: widget),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14.0), // space above solo
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Solo Projects",
                  style: GoogleFonts.openSans(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0), //space below solo
              SizedBox(
                height: 196,
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left:16 ,right: 6),
                    scrollDirection: Axis.horizontal,
                    itemCount: soloProjects.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: 50,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: CustomCard(name: soloProjects[index]['name'], imageAsset: soloProjects[index]['imageAsset'], widget: soloProjects[index]['widget']),
                            ),
                          ),
                        ),
                      );
                    },
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
