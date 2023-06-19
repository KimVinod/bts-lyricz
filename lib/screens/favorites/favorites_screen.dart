import 'dart:developer';
import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_song_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class FavoritesScreen extends StatefulWidget {
  final ScrollController controller;
  const FavoritesScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  late Box userFavLyricsBox;
  List userFavLyrics = [];
  bool isFav = false, isBoxInit = false;

  Future loadData() async {
    userFavLyricsBox = await Hive.openBox('userFavourites');
    setState(() {
      userFavLyrics = userFavLyricsBox.get('favouritesList',defaultValue: []);
      userFavLyrics = userFavLyrics.reversed.toList();
      isBoxInit = true;
    });
    log("load favList: $userFavLyrics");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          color: appUILightColor,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: appUILightColor,
            elevation: 4,
            child: Stack(
              children: [
                Align(
                  child: Text(
                    "Favorites",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: "Remove all",
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            backgroundColor: appUILightColor,
                            title: const Text("Do you want to remove all songs?", style: TextStyle(fontSize: 16),),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              }, style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.white30)), child: const Text("NO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),)),
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                                userFavLyrics = [];
                                userFavLyricsBox.put("favouritesList", userFavLyrics);
                                setState(() {});
                              }, style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.white30)), child: const Text("YES", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),)),
                            ]
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: isBoxInit
              ? userFavLyrics.isNotEmpty
                  ? Column(
            children: [
              const SizedBox(height: 16),
              Text("Swipe to remove songs  >.<",style: GoogleFonts.openSans(fontStyle: FontStyle.italic)),
              const SizedBox(height: 12),
              Expanded(
                child: AnimationLimiter(
                  child: RawScrollbar(
                    controller: widget.controller,
                    thumbColor: appThumbBarColor,
                    thickness: 7.0,
                    radius: const Radius.circular(15.0),
                    thumbVisibility: false,
                    child: ListView.builder(
                      controller: widget.controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: userFavLyrics.length,
                      itemBuilder: (context, index) {
                        //using try catch so that if i incase change song name later, UI shouldn't throw error
                        try{
                          final item = userFavLyrics[index];
                          final song = allSongs.firstWhere((s) => s.name == item);
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                                  child: Dismissible(
                                    key: Key(item),
                                    onDismissed: (DismissDirection direction) {
                                      userFavLyrics.remove(item);
                                      userFavLyricsBox.put("favouritesList", userFavLyrics);
                                      setState(() {});
                                    },
                                    child: CustomSongMiniCard(song: song),
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
                    child: Image.asset(getBt21Pic(), height: MediaQuery.of(context).size.height * 0.23)),
              const SizedBox(height: 10),
              Text("Nothing here  ~.~", style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),),
              const SizedBox(height: 20),
              Text("Add your favorite songs by clicking on the heart icon in the lyrics screen", textAlign: TextAlign.center, style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset("images/fav_hint.jpg")),
              ),
              const SizedBox(height: 56),
            ],

          ),
                  )
              : const SizedBox(),
        ),
      ],
    );
  }
}
