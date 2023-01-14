import 'dart:developer';
import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  late Box userFavLyricsBox;
  List userFavLyrics = [];
  bool isFav = false;

  loadData() async {
    userFavLyricsBox = await Hive.openBox('userFavourites');
    setState(() {
      userFavLyrics = userFavLyricsBox.get('favouritesList',defaultValue: []);
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
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleSpacing: 0,
          title: Text("Favorites", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
          backgroundColor: appBarColor,
          actions: [
            if(userFavLyrics.isNotEmpty)...[
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: "Remove all",
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
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
            ]
          ],
        ),
        backgroundColor: appUILightColor,
        body: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification> (
            onNotification: (OverscrollIndicatorNotification overScroll){
              overScroll.disallowIndicator();
              return true;
            },
            child: userFavLyrics.isNotEmpty
                ? Column(
                  children: [
                    const SizedBox(height: 10),
                    Text("Swipe to remove songs  >.<",style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontStyle: FontStyle.italic
                    ),),
                    const SizedBox(height: 10),
                    Expanded(
                      child: RawScrollbar(
                        thumbColor: const Color.fromRGBO(130, 70, 190, 1),
                        thickness: 7.0,
                        radius: const Radius.circular(15.0),
                        thumbVisibility: false,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 15),
                          itemCount: userFavLyrics.length,
                          itemBuilder: (context, index) {
                            final item = userFavLyrics[index];
                            final song = allSongs.firstWhere((s) => s.name == item);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Dismissible(
                                key: Key(item),
                                onDismissed: (DismissDirection direction) {
                                  userFavLyrics.remove(item);
                                  userFavLyricsBox.put("favouritesList", userFavLyrics);
                                  setState(() {});
                                  },
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 3,
                              color: Colors.transparent,
                              shadowColor: Colors.purple.shade700,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(152, 105, 190, 1),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              userFavLyrics[index],
                                              style: GoogleFonts.openSans(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(20),
                                          onTap: () {
                                            switch(song.lang) {
                                              case "eng":
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsENG(
                                                  songFullName: song.name,
                                                  songName: song.displayName,
                                                  songTabs: const [1,0,0,0],
                                                  songLyrics: song.lyrics,
                                                ))).then((value) => setState(() {}));
                                                break;
                                              case "kr":
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsKR(
                                                  songFullName: song.name,
                                                  songName: song.displayName,
                                                  songTabs: const [1,1,1,0],
                                                  songLyrics: song.lyrics,
                                                ))).then((value) => setState(() {}));
                                                break;
                                              case "jp":
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsJP(
                                                  songFullName: song.name,
                                                  songName: song.displayName,
                                                  songTabs: const [1,1,0,1],
                                                  songLyrics: song.lyrics,
                                                ))).then((value) => setState(() {}));
                                                break;
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
              },
            ),
                      ),
                    ),
                  ],
                )
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: ()=> setState(() {}),
                          child: Image.asset(getBt21Pic(), height: MediaQuery.of(context).size.height * 0.25)),
                      Text("Nothing here  ~.~", style: GoogleFonts.openSans(fontSize: 18, fontStyle: FontStyle.italic),),
                      const SizedBox(height: 20),
                      Text("Add your favorite songs by clicking on the heart icon in the lyrics screen", textAlign: TextAlign.center, style: GoogleFonts.openSans(fontSize: 18, fontStyle: FontStyle.italic),),
                      const SizedBox(height: 20),
                      ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset("images/fav_hint.jpg"))
                    ],

            ),
                )

          )
        ),
      );
  }
}
