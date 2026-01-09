import 'package:bts_lyricz/data/song_data.dart';
import 'package:bts_lyricz/utils/widgets/custom_song_mini_card.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {

  late Box userFavLyricsBox;
  List userFavLyrics = [];
  bool isFav = false, isBoxInit = false;

  Future loadData() async {
    userFavLyricsBox = await Hive.openBox('userFavourites');
    userFavLyrics = userFavLyricsBox.get('favouritesList',defaultValue: []);
    setState(() {
      userFavLyrics = userFavLyrics.reversed.toList();
      isBoxInit = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text("Favorites", style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.bold)),
          actions: userFavLyrics.isNotEmpty ? [
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: "Remove all",
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      title: const Text("Remove all songs"),
                      content: const Text("Are you sure you want to remove all songs from your favorites?"),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text("No", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),)),
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                          userFavLyrics = [];
                          userFavLyricsBox.put("favouritesList", userFavLyrics);
                          setState(() {});
                        },child: Text("Yes", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),)),
                      ]
                  );
                });
              },
            )
          ] : [],
        ),
      ],
      body: isBoxInit
          ? userFavLyrics.isNotEmpty
          ? Column(
          children: [
          const SizedBox(height: 16),
          Text("Swipe to remove songs  >.<",style: GoogleFonts.openSans(fontStyle: FontStyle.italic)),
          Expanded(
            child: AnimationLimiter(
              child: RawScrollbar(
                thumbColor: Theme.of(context).focusColor,
                thickness: 7.0,
                radius: const Radius.circular(15.0),
                thumbVisibility: false,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: userFavLyrics.length,
                  itemBuilder: (context, index) {
                    //using try catch so that if incase song name gets changed later, UI shouldn't throw error
                    try{
                      final item = userFavLyrics[index];
                      final song = allSongs.firstWhere((s) => s.name == item);
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Dismissible(
                                key: Key(item),
                                onDismissed: (DismissDirection direction) {
                                  userFavLyrics.remove(item);
                                  userFavLyricsBox.put("favouritesList", userFavLyrics);
                                  setState(() {});
                                },
                                child: CustomSongMiniCard(song: song, onFinish: () => loadData()),
                              ),
                            ),
                          ),
                        ),
                      );
                    } catch(e) {
                      userFavLyrics = [];
                      userFavLyricsBox.put("favouritesList", userFavLyrics);
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ],
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: ()=> setState(() {}),
                child: Image.asset(getBt21Pic(), height: MediaQuery.sizeOf(context).height * 0.25)),
            const SizedBox(height: 10),
            Text("Nothing here  ~.~", style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),),
            const SizedBox(height: 20),
            Text("Add your favorite songs by clicking the heart ♡ icon on the lyrics screen.", textAlign: TextAlign.center, style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),),
          ],
        ),
      )
          : const SizedBox(),
    );
  }
}
