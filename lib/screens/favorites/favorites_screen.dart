import 'dart:developer';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import '../../data/album_data.dart';

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
    //userFavLyricsBox.clear();
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
          title: Text("Favorites", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
          backgroundColor: appBarColor,
          actions: [
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
                                            switch (item) {
                                              case "Still With You":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "STILL WITH YOU",
                                                            songLyrics: AlbumData().jungkookStillWithYou,
                                                            songTabs: AlbumData().jungkookOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Dynamite":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics:
                                                        AlbumData().dynamiteLyrics,
                                                        songName: "DYNAMITE",
                                                        songTabs: AlbumData().dynamiteTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Butter":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics: AlbumData().butterLyrics,
                                                        songName: "BUTTER",
                                                        songTabs: AlbumData().btsENGSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Butter (ft. Megan Thee Stallion)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics: AlbumData().butterRemix,
                                                        songName: "BUTTER (FT. MEGAN THE STALLION)",
                                                        songTabs: AlbumData().btsENGSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "MIC Drop (Steve Aoki Remix) (ft. Desiigner)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().btsMICDropDesiigner,
                                                        songName: "MIC DROP",
                                                        songTabs: AlbumData().btsSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Waste It On Me":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics: AlbumData().btsWasteItOnMe,
                                                        songName: "WASTE IT ON ME",
                                                        songTabs: AlbumData().btsENGSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Make It Right (ft. Lauv)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().btsMakeItRightLauv,
                                                        songName: "MAKE IT RIGHT",
                                                        songTabs: AlbumData().btsSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Black Swan":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().mots7BlackSwan,
                                                        songName: "BLACK SWAN",
                                                        songTabs: AlbumData().btsSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Who (Lauv ft. BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics:
                                                        AlbumData().btsWho,
                                                        songName: "WHO",
                                                        songTabs: AlbumData().btsENGSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Film Out":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().btsTheBestFilmOut,
                                                        songName: "FILM OUT",
                                                        songTabs: AlbumData().btsJPSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Savage Love (Laxed - Siren Beat) (BTS Remix)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics:
                                                        AlbumData().btsSavageLove,
                                                        songName: "SAVAGE LOVE",
                                                        songTabs: AlbumData().btsENGSinglesTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "1 Verse":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().jhope1Verse,
                                                        songName: "1 VERSE",
                                                        songTabs: AlbumData().jhopeOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Chicken Noodle Soup (ft. Becky G)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().jhopeCNS,
                                                        songName: "CHICKEN NOODLE SOUP",
                                                        songTabs: AlbumData().jhopeOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Blue Side":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().jhopeBlueSide,
                                                        songName: "BLUE SIDE",
                                                        songTabs: AlbumData().jhopeOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Promise)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "?????? (PROMISE)",
                                                            songLyrics: AlbumData().jiminPromise,
                                                            songTabs: AlbumData().jiminOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Christmas Love":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "CHRISTMAS LOVE",
                                                            songLyrics: AlbumData().jiminChristmasLove,
                                                            songTabs: AlbumData().jiminOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??? ??? (Tonight)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "??? ??? (TONIGHT)",
                                                            songLyrics: AlbumData().jinTonight,
                                                            songTabs: AlbumData().jinOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Abyss":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "ABYSS",
                                                            songLyrics: AlbumData().jinAbyss,
                                                            songTabs: AlbumData().jinOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "P.D.D (Please Don't Die) (Rap Monster x Warren G)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "P.D.D",
                                                            songLyrics: AlbumData().rmPDD,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? (Buckubucku) (MFBTY ft. EE, RM and Dino-J)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "???????????? (Buckubucku)",
                                                            songLyrics: AlbumData().rmBuckubucku,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "U (Primary ft. ????????? Kwon Jin Ah, Rap Monster)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "U",
                                                            songLyrics: AlbumData().rmU,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Change (RM & Wale)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "CHANGE",
                                                            songLyrics: AlbumData().rmChange,
                                                            songTabs: AlbumData().rmChangeTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Gajah (?????????) (Gaeko (??????) ft. Rap Monster)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "GAJAH (?????????)",
                                                            songLyrics: AlbumData().rmGajah,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Champion (Remix) (Fall Out Boy ft. RM)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "CHAMPION (REMIX)",
                                                            songLyrics: AlbumData().rmChampion,
                                                            songTabs: AlbumData().rmChampionTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Monterlude":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "MONTERLUDE",
                                                            songLyrics: AlbumData().rmMonterlude,
                                                            songTabs: AlbumData().rmMonterludeTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Unpack your Bags (SOULSCAPE x Rap Monster)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "UNPACK YOUR BAGS",
                                                            songLyrics: AlbumData().rmUnpackYourBags,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Always":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "ALWAYS",
                                                            songLyrics: AlbumData().rmAlways,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Timeless (Drunken Tiger ft. RM)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "TIMELESS",
                                                            songLyrics: AlbumData().rmTimeless,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Crying Over You ??? (Remix) (HONNE ft. RM & BEKA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "CRYING OVER YOU ??? (REMIX)",
                                                            songLyrics: AlbumData().rmCryingOverYou,
                                                            songTabs: AlbumData().rmCryingOverYouTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Old Town Road (Seoul Town Road Remix) (Lil Nas ft. RM)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "OLD TOWN ROAD (SEOUL TOWN ROAD REMIX)",
                                                            songLyrics: AlbumData().rmSeoulTownRoad,
                                                            songTabs: AlbumData().rmSeoulTownRoadTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Winter Flower (?????????) (YOUNHA (??????) ft. RM)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "WINTER FLOWER (?????????)",
                                                            songLyrics: AlbumData().rmWinterFlower,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ??? (Don???t) (eAeon (?????????) ft. RM)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "????????? ??? (DON???T)",
                                                            songLyrics: AlbumData().rmDont,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Bicycle":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "BICYCLE",
                                                            songLyrics: AlbumData().rmBicycle,
                                                            songTabs: AlbumData().rmOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Permission to Dance":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics: AlbumData().ptdLyrics,
                                                        songName: "PERMISSION TO DANCE",
                                                        songTabs:
                                                        AlbumData().butterPtdAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Life Goes On":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().beLgoLyrics,
                                                        songName: "LIFE GOES ON",
                                                        songTabs: AlbumData().beAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Fly To My Room":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().beFtmrLyrics,
                                                        songName: "FLY TO MY ROOM",
                                                        songTabs: AlbumData().beAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Blue & Grey":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().beBgLyrics,
                                                        songName: "BLUE & GREY",
                                                        songTabs: AlbumData().beAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Telepathy":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().beTelepathyLyrics,
                                                        songName: "TELEPATHY",
                                                        songTabs: AlbumData().beAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Dis-ease":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().beDiseaseLyrics,
                                                        songName: "DIS-EASE",
                                                        songTabs: AlbumData().beAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Stay":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().beStayLyrics,
                                                        songName: "STAY",
                                                        songTabs: AlbumData().beAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: 2 Cool 4 Skool":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .twoCool4Skool2Cool4SkoolLyrics,
                                                        songName: "INTRO: 2 COOL 4 SKOOL",
                                                        songTabs:
                                                        AlbumData().twoCool4SkoolTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "We Are Bulletproof Pt.2":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().twoCool4SkoolWabPt2,
                                                        songName: "WE ARE BULLETPROOF PT.2",
                                                        songTabs:
                                                        AlbumData().twoCool4SkoolTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "No More Dream":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .twoCool4SkoolNoMoreDream,
                                                        songName: "NO MORE DREAM",
                                                        songTabs:
                                                        AlbumData().twoCool4SkoolTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Like)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().twoCool4SkoolLike,
                                                        songName: "????????? (LIKE)",
                                                        songTabs:
                                                        AlbumData().twoCool4SkoolTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: Circle Room Cypher":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().twoCool4SkoolOutro,
                                                        songName: "OUTRO: CIRCLE ROOM CYPHER",
                                                        songTabs:
                                                        AlbumData().twoCool4SkoolTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??? (Road/Path)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().twoCool4SkoolPath,
                                                        songName: "??? (ROAD/PATH)",
                                                        songTabs:
                                                        AlbumData().twoCool4SkoolTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: O!RUL8,2?":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().orul82Intro,
                                                        songName: "INTRO: O!RUL8,2?",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "N.O":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().orul82No,
                                                        songName: "N.O",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "We On":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().orul82WeOn,
                                                        songName: "WE ON",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "If I Ruled the World":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .orul82IfiRuledTheWorld,
                                                        songName: "IF RULED THE WORLD",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Coffee":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().orul82Coffee,
                                                        songName: "COFFEE",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "BTS Cypher Pt.1":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().orul82CypherPt1,
                                                        songName: "BTS CYPHER PT.1",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ?????? (Attack on Bangtan)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().orul82AttackOnBangtan,
                                                        songName:
                                                        "????????? ?????? (ATTACK ON BANGTAN)",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? (Paldogangsan)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().orul82Paldogangsan,
                                                        songName: "???????????? (PALDOGANGSAN)",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: LUV IN SKOOL":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().orul82Outro,
                                                        songName: "OUTRO: LUV IN SKOOL",
                                                        songTabs: AlbumData().orul82Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: Skool Luv Affair":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().skoolLuvAffairIntro,
                                                        songName: "INTRO: SKOOL LUV AFFAIR",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Boy in Luv)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .skoolLuvAffairBoyInLuv,
                                                        songName: "????????? (BOY IN LUV)",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? ????????? (Where You From)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .skoolLuvAffairWhereYouFrom,
                                                        songName: "???????????? ????????? (WHERE YOU FROM)",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Just One Day)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .skoolLuvAffairJustOneDay,
                                                        songName: "????????? (JUST ONE DAY)",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Tomorrow":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .skoolLuvAffairTomorrow,
                                                        songName: "TOMORROW",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "BTS Cypher Pt. 2: Triptych":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().skoolLuvAffairCypher2,
                                                        songName: "BTS CYPHER PT.2: TRIPTYCH",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????????????????? (Spine Breaker)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .skoolLuvAffairSpineBreaker,
                                                        songName: "?????????????????? (SPINE BREAKER)",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Jump":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().skoolLuvAffairJump,
                                                        songName: "JUMP",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: Purpose":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().skoolLuvAffairJump,
                                                        songName: "OUTRO: PURPOSE",
                                                        songTabs:
                                                        AlbumData().skoolLuvAffairTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: What Am I to You":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildIntro,
                                                        songName: "INTRO: WHAT AM I TO YOU",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Danger":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildDanger,
                                                        songName: "DANGER",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ?????? (War of Hormone)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .darkAndWildWarOfHormone,
                                                        songName: "????????? ?????? (WAR OF HORMONE)",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??????????????? (Hip Hop Phile)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .darkAndWildHipHopePhile,
                                                        songName: "??????????????? (HIP HOP PHILE)",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Let Me Know":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildLetMeKnow,
                                                        songName: "LET ME KNOW",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "BTS Cypher Pt. 3: KILLER":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildCypher3,
                                                        songName: "BTS CYPHER PT. 3: KILLER",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ??? ????????? (Could You Turn off Your Cell Phone?)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildCellphone,
                                                        songName:
                                                        "????????? ??? ????????? (COULD YOU TURN OFF YOUR CELLPHONE)?)",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Embarrassed)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .darkAndWildEmbarrassed,
                                                        songName: "????????? (EMBARRASSED)",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "24/7=Heaven":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildHeaven,
                                                        songName: "24/7=HEAVEN",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "2?????? (Second Grade)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .darkAndWildSecondGrade,
                                                        songName: "2?????? (SECOND GRADE)",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: ?????? ?????? ???? (Do You Think It Makes Sense?)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .darkAndWildSecondGrade,
                                                        songName:
                                                        "OUTRO: ?????? ?????? ???? (DO YOU THINK IT MAKES SENSE?)",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: ???????????? (The Most Beautiful Moment in Life)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh1Intro,
                                                        songName:
                                                        "Intro: ???????????? (THE MOST BEAUTIFUL MOMENT IN LIFE)",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "I Need U":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh1INeedU,
                                                        songName: "I NEED U",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Hold Me Tight)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().hyyh1HoldMeTight,
                                                        songName: "????????? (HOLD ME TIGHT)",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Dope)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh1Dope,
                                                        songName: "?????? (DOPE)",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??????????????? (Boyz with Fun)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().hyyh1BoyzWithFun,
                                                        songName: "??????????????? (BOYZ WITH FUN)",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Converse High":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().hyyh1ConverseHigh,
                                                        songName: "CONVERSE HIGH",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Moving On)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh1MovingOn,
                                                        songName: "?????? (MOVING ON)",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: Love is Not Over":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh1Outro,
                                                        songName: "OUTRO: LOVE IS NOT OVER",
                                                        songTabs: AlbumData().hyyh1Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: Never Mind":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh2Intro,
                                                        songName: "INTRO: NEVER MIND",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Run":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh2Run,
                                                        songName: "RUN",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Whalien 52":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().hyyh2Whalien52,
                                                        songName: "WHALIEN 52",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Ma City":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh2MaCity,
                                                        songName: "MA CITY",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Silver Spoon)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().hyyh2SilverSpoon,
                                                        songName: "?????? (SILVER SPOON)",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Autumn Leaves)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().hyyh2AutumnLeaves,
                                                        songName: "?????? (AUTUMN LEAVES)",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: House of Cards":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hyyh2Outro,
                                                        songName: "OUTRO: HOUSE OF CARDS",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Fire (???????????????)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().youngForeverFire,
                                                        songName: "FIRE (???????????????)",
                                                        songTabs:
                                                        AlbumData().youngForeverTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Epilogue: Young Forever":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().youngForeverEpilogue,
                                                        songName: "EPILOGUE: YOUNG FOREVER",
                                                        songTabs:
                                                        AlbumData().youngForeverTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Butterfly (Prologue Mix)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .youngForeverButterflyPrologueMix,
                                                        songName: "BUTTERFLY (PROLOGUE MIX)",
                                                        songTabs:
                                                        AlbumData().youngForeverTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "House of Cards (Full Length Edition)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .youngForeverHouseOFCardsFull,
                                                        songName:
                                                        "HOUSE OF CARDS (FULL LENGTH EDITION)",
                                                        songTabs:
                                                        AlbumData().youngForeverTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Love Is Not Over (Full Length Edition)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .youngForeverLoveIsNotOverFull,
                                                        songName:
                                                        "LOVE IS NOT OVER (FULL LENGTH EDITION)",
                                                        songTabs:
                                                        AlbumData().youngForeverTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: Boy Meets Evil":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsIntro,
                                                        songName: "INTRO: BOY MEETS EVIL",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??? ??? ?????? (Blood Sweat & Tears)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsIntro,
                                                        songName:
                                                        "??? ??? ?????? (BLOOD SWEAT & TEARS)",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Begin":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsBegin,
                                                        songName: "BEGIN",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Lie":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsLie,
                                                        songName: "LIE",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Stigma":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsStigma,
                                                        songName: "STIGMA",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "First Love":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().wingsFirstlove,
                                                        songName: "FIRST LOVE",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Reflection":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().wingsReflection,
                                                        songName: "REFLECTION",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Mama":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsMama,
                                                        songName: "MAMA",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Awake":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsAwake,
                                                        songName: "AWAKE",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Lost":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsLost,
                                                        songName: "LOST",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "BTS Cypher 4":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsCypher4,
                                                        songName: "BTS CYPHER 4",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Am I Wrong":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wingsAmIWrong,
                                                        songName: "AM I WRONG",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "21?????? ?????? (21st Century Girl)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().wings21CenturyGirls,
                                                        songName:
                                                        "21?????? ?????? (21ST CENTURY GIRL)",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???! ???! (2! 3!)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().wings23,
                                                        songName: "???! ???! (2! 3!)",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Interlude: Wings":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().wingsInterlude,
                                                        songName: "Interlude: Wings",
                                                        songTabs: AlbumData().wingsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Spring Day)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().ynwaSpringDay,
                                                        songName: "?????? (SPRING DAY)",
                                                        songTabs: AlbumData().ynwaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Not Today":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().ynwaNotToday,
                                                        songName: "NOT TODAY",
                                                        songTabs: AlbumData().ynwaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: Wings":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().ynwaOutro,
                                                        songName: "OUTRO: WINGS",
                                                        songTabs: AlbumData().ynwaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "A Supplementary Story: You Never Walk Alone":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().ynwaYNWA,
                                                        songName:
                                                        "A SUPPLEMENTARY STORY: YOU NEVER WALK ALONE",
                                                        songTabs: AlbumData().ynwaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: Serendipity (???????????????)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerIntro,
                                                        songName:
                                                        "INTRO: SERENDIPITY (???????????????)",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "DNA":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerDNA,
                                                        songName: "DNA",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Best Of Me":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerBesOfMe,
                                                        songName: "BEST OF Me",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (dimple)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerDimple,
                                                        songName: "????????? (DIMPLE)",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Pied Piper":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyHerPiedPiper,
                                                        songName: "PIED PIPER",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "MIC Drop":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerMICDrop,
                                                        songName: "MIC DROP",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? Go (Go Go)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerGoGo,
                                                        songName: "???????????? Go (GO GO)",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Sea)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerSea,
                                                        songName: "?????? (SEA)",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: Her":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerOutro,
                                                        songName: "OUTRO: HER",
                                                        songTabs: AlbumData().lyHerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: Singularity":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyTearIntro,
                                                        songName: "INTRO: SINGULARITY",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "FAKE LOVE":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyTearFakeLove,
                                                        songName: "FAKE LOVE",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ?????? ?????? (The Truth Untold)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyTearTTU,
                                                        songName:
                                                        "????????? ?????? ?????? (THE TRUTH UNTOLD)",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "134340":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyTear134340,
                                                        songName: "134340",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Paradise)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyTearParadise,
                                                        songName: "?????? (PARADISE)",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Love Maze":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyTearLoveMaze,
                                                        songName: "LOVE MAZE",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Magic Shop":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyTearMagicShop,
                                                        songName: "MAGIC SHOP",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Airplane pt.2":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyTearAirplanePt2,
                                                        songName: "AIRPLANE PT.2",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Anpanman":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyTearAnpanman,
                                                        songName: "ANPANMAN",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "So What":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyTearSoWhat,
                                                        songName: "SO WHAT",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: tear":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyTearOutro,
                                                        songName: "OUTRO: TEAR",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Euphoria":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerEuphoria,
                                                        songName: "EUPHORIA",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Trivia ???: Just Dance":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerJustDance,
                                                        songName: "TRIVIA ???: JUST DANCE",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Serendipity (Full Length Edition)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .lyAnswerSerendipityFull,
                                                        songName:
                                                        "SERENDIPITY (FULL LENGTH EDITION)",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Trivia ???: Love":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyAnswerLove,
                                                        songName: "TRIVIA ???: LOVE",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Her":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyHerOutro,
                                                        songName: "HER",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Singularity":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyTearIntro,
                                                        songName: "SINGULARITY",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Trivia ???: Seesaw":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerSeesaw,
                                                        songName: "TRIVIA ???: SEESAW",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Epiphany":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerEpiphany,
                                                        songName: "EPIPHANY",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "I'm Fine":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerImFine,
                                                        songName: "I'M FINE",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Answer: Love Myself":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerLoveMyself,
                                                        songName: "ANSWER: LOVE MYSELF",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "MIC Drop (Full Length Edition)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerMICDropFull,
                                                        songName:
                                                        "MIC DROP (FULL LENGTH EDITION)",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Idol (ft. Nicki Minaj)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().lyAnswerIdolRemix,
                                                        songName: "IDOL (FT. NICKI MINAJ)",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: Persona":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().motsPersonaIntro,
                                                        songName: "INTRO: PERSONA",
                                                        songTabs: AlbumData().motsPersonaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? ????????? ?????? ??? (Boy With Luv)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().motsPersonaBWL,
                                                        songName:
                                                        "?????? ????????? ?????? ??? (BOY WITH LUV)",
                                                        songTabs: AlbumData().motsPersonaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Mikrokosmos)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData()
                                                            .motsPersonaMikrokosmos,
                                                        songName: "????????? (MIKROKOSMOS)",
                                                        songTabs: AlbumData().motsPersonaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Make It Right":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().motsPersonaMIR,
                                                        songName: "MAKE IT RIGHT",
                                                        songTabs: AlbumData().motsPersonaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "HOME":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().motsPersonaHome,
                                                        songName: "HOME",
                                                        songTabs: AlbumData().motsPersonaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Jamais Vu":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().motsPersonaJamaisVu,
                                                        songName: "JAMAIS VU",
                                                        songTabs: AlbumData().motsPersonaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Dionysus":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().motsPersonaDionysus,
                                                        songName: "DIONYSUS",
                                                        songTabs: AlbumData().motsPersonaTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Interlude: Shadow":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().mots7Interlude,
                                                        songName: "INTERLUDE: SHADOW",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Filter":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7Filter,
                                                        songName: "Filter",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (My Time)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7MyTime,
                                                        songName: "?????? (MY TIME)",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Louder than Bombs":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7LDR,
                                                        songName: "LOUDER THAN BOMBS",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "ON":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7ON,
                                                        songName: "ON",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??? (UGH!)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7Ugh,
                                                        songName: "??? (UGH!)",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "00:00 (Zero O???Clock)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().mots7ZeroOClock,
                                                        songName: "00:00 (ZERO O'CLOCK)",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Inner Child":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().mots7InnerChild,
                                                        songName: "INNER CHILD",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Friends)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7Friends,
                                                        songName: "?????? (FRIENDS)",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Moon":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7Moon,
                                                        songName: "MOON",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Respect":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7Respect,
                                                        songName: "RESPECT",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "We Are Bulletproof: The Eternal":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().mots7WAPTheEternal,
                                                        songName:
                                                        "WE ARE BULLETPROOF: THE ETERNAL",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro: Ego":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7Outro,
                                                        songName: "OUTRO: EGO",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "ON (Ft. Sia)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().mots7OnSia,
                                                        songName: "ON (FT. SIA)",
                                                        songTabs: AlbumData().mots7Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "No More Dream (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData()
                                                            .noMoreDreamNoMoreDream,
                                                        songName: "NO MORE DREAM",
                                                        songTabs: AlbumData().noMoreDreamTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????????! (I Like It) (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().noMoreDreamILikeIt,
                                                        songName: "?????????! (I LIKE IT)",
                                                        songTabs: AlbumData().noMoreDreamTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??????????????? (Attack on Bangtan) (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData()
                                                            .noMoreDreamAttackOnBangtan,
                                                        songName: "??????????????? (ATTACK ON BANGTAN)",
                                                        songTabs: AlbumData().noMoreDreamTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Boy In Luv (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().boyInLuvBoyInLuv,
                                                        songName: "BOY IN LUV",
                                                        songTabs: AlbumData().boyInLuvTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "N.O (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().boyInLuvNO,
                                                        songName: "N.O",
                                                        songTabs: AlbumData().boyInLuvTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Just One Day (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().boyInLuvJustOneDay,
                                                        songName: "JUST ONE DAY",
                                                        songTabs: AlbumData().boyInLuvTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Danger (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().dangerDanger,
                                                        songName: "DANGER",
                                                        songTabs: AlbumData().dangerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Miss Right (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().dangerMissRight,
                                                        songName: "MISS RIGHT",
                                                        songTabs: AlbumData().dangerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro.":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().wakeUpIntro,
                                                        songName: "INTRO.",
                                                        songTabs: AlbumData().wakeUpTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "The Stars":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().wakeUpTheStars,
                                                        songName: "THE STARS",
                                                        songTabs: AlbumData().wakeUpTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Jump (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().wakeUpJump,
                                                        songName: "JUMP",
                                                        songTabs: AlbumData().wakeUpTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????????! Pt.2 ????????????????????? (I Like It Pt.2)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().wakeUpILikeItPt2,
                                                        songName:
                                                        "?????????! PT.2 ????????????????????? (I LIKE IT PT.2)",
                                                        songTabs: AlbumData().wakeUpTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Just One Day (Japanese Ver. Extended)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().boyInLuvJustOneDay,
                                                        songName:
                                                        "JUST ONE DAY (EXTENDED VER.)",
                                                        songTabs: AlbumData().wakeUpTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Wake Up":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().wakeUpWakeUp,
                                                        songName: "WAKE UP",
                                                        songTabs: AlbumData().wakeUpTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Outro.":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().wakeUpOutro,
                                                        songName: "OUTRO.",
                                                        songTabs: AlbumData().wakeUpTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "For You":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().forYouForYou,
                                                        songName: "FOR YOU",
                                                        songTabs: AlbumData().forYouTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????????????????? (War of Hormone) (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().forYouWarOfHormone,
                                                        songName: "?????????????????? (WAR OF HORMONE)",
                                                        songTabs: AlbumData().forYouTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Let Me Know (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().forYouLetMeKnow,
                                                        songName: "LET ME KNOW",
                                                        songTabs: AlbumData().forYouTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "I Need U (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().iNeedUINeedU,
                                                        songName: "I NEED U",
                                                        songTabs: AlbumData().iNeedUTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Dope -????????????!- (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().iNeedUDope,
                                                        songName: "DOPE -????????????!-",
                                                        songTabs: AlbumData().iNeedUTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????????????????? (Boyz With Fun) (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().iNeedUBoyzWithFun,
                                                        songName: "????????????????????? (BOYZ WITH FUN)",
                                                        songTabs: AlbumData().iNeedUTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Run (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().runRun,
                                                        songName: "RUN",
                                                        songTabs: AlbumData().runTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Butterfly (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().runButterfly,
                                                        songName: "BUTTERFLY",
                                                        songTabs: AlbumData().runTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Good Day":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().runGoodDay,
                                                        songName: "GOOD DAY",
                                                        songTabs: AlbumData().runTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Introduction: Youth":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().youthIntro,
                                                        songName: "INTRODUCTION: YOUTH",
                                                        songTabs: AlbumData().youthTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? (Silver Spoon) (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().youthSilverSpoon,
                                                        songName: "???????????? (SILVER SPOON)",
                                                        songTabs: AlbumData().youthTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Wishing On a Star":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().youthWishingOnAStar,
                                                        songName: "WISHING ON A STAR",
                                                        songTabs: AlbumData().youthTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Epilogue : Young Forever (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().youthEpilogue,
                                                        songName: "EPILOGUE: YOUNG FOREVER",
                                                        songTabs: AlbumData().youthTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Fire (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().youthFire,
                                                        songName: "FIRE",
                                                        songTabs: AlbumData().youthTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Save Me (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().youthSaveMe,
                                                        songName: "SAVE ME",
                                                        songTabs: AlbumData().youthTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??????????????? (Blood Sweat & Tears (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().bstBST,
                                                        songName:
                                                        "??????????????? (Blood Sweat & Tears)",
                                                        songTabs: AlbumData().bstTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Not Today (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().bstNotToday,
                                                        songName: "NOT TODAY",
                                                        songTabs: AlbumData().bstTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Spring Day (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().bstSpringDay,
                                                        songName: "SPRING DAY",
                                                        songTabs: AlbumData().bstTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "MIC Drop (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().crystalSnowMICDrop,
                                                        songName: "MIC DROP",
                                                        songTabs: AlbumData().crystalSnowTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "DNA (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().crystalSnowDNA,
                                                        songName: "DNA",
                                                        songTabs: AlbumData().crystalSnowTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Crystal Snow":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData()
                                                            .crystalSnowCrystalSnow,
                                                        songName: "CRYSTAL SNOW",
                                                        songTabs: AlbumData().crystalSnowTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "INTRO: Ringwanderung":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().faceYourselfIntro,
                                                        songName: "INTRO: RINGWANDERUNG",
                                                        songTabs:
                                                        AlbumData().faceYourselfTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Don't Leave Me":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData()
                                                            .faceYourselfDontLeaveMe,
                                                        songName: "DON'T LEAVE ME",
                                                        songTabs:
                                                        AlbumData().faceYourselfTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Go Go (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().faceYourselfGoGo,
                                                        songName: "GO GO",
                                                        songTabs:
                                                        AlbumData().faceYourselfTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Let Go":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().faceYourselfLetGo,
                                                        songName: "LET GO",
                                                        songTabs:
                                                        AlbumData().faceYourselfTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "OUTRO: Crack":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().faceYourselfOutro,
                                                        songName: "OUTRO: CRACK",
                                                        songTabs:
                                                        AlbumData().faceYourselfTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "FAKE LOVE (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().fakeLoveFakeLove,
                                                        songName: "FAKE LOVE",
                                                        songTabs: AlbumData().fakeLoveTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Airplane pt.2 (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().fakeLoveAirplanePt2,
                                                        songName: "AIRPLANE PT.2",
                                                        songTabs: AlbumData().fakeLoveTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Lights":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().lightsLights,
                                                        songName: "LIGHTS",
                                                        songTabs: AlbumData().lightsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Boy With Luv (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().lightsBoyWithLuv,
                                                        songName: "BOY WITH LUV",
                                                        songTabs: AlbumData().lightsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Idol (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().lightsIdol,
                                                        songName: "IDOL",
                                                        songTabs: AlbumData().lightsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "INTRO: Calling":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().motsJourneyIntro,
                                                        songName: "INTRO: CALLING",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Stay Gold":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().motsJourneyStayGold,
                                                        songName: "STAY GOLD",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Make It Right (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData()
                                                            .motsJourneyMakeItRight,
                                                        songName: "MAKE IT RIGHT",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Dionysus (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().motsJourneyDionysus,
                                                        songName: "DIONYSUS",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Black Swan (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().motsJourneyBlackSwan,
                                                        songName: "BLACK SWAN",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "ON (Japanese ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData().motsJourneyOn,
                                                        songName: "ON",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Your eyes tell":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics: AlbumData()
                                                            .motsJourneyYourEyesTell,
                                                        songName: "YOUR EYES TELL",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "OUTRO: The Journey":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().motsJourneyOutro,
                                                        songName: "OUTRO: THE JOURNEY",
                                                        songTabs: AlbumData().motsJourneyTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? ??? (Look Here)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildLookHere,
                                                        songName: "?????? ??? (LOOK HERE)",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Rain":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().darkAndWildRain,
                                                        songName: "RAIN",
                                                        songTabs: AlbumData().darkAndWildTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Butterfly":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().hyyh2Butterfly,
                                                        songName: "BUTTERFLY",
                                                        songTabs: AlbumData().hyyh2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Save Me":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().youngForeverSaveMe,
                                                        songName: "SAVE ME",
                                                        songTabs:
                                                        AlbumData().youngForeverTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Tear":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyTearOutro,
                                                        songName: "TEAR",
                                                        songTabs: AlbumData().lyTearTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Idol":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().lyAnswerIdol,
                                                        songName: "IDOL",
                                                        songTabs: AlbumData().lyAnswerTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Best Of Me (Japanese Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songLyrics:
                                                        AlbumData().faceYourselfBestOfMe,
                                                        songName: "BEST OF ME",
                                                        songTabs:
                                                        AlbumData().faceYourselfTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Heartbeat":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().btsWorldHeartbeat,
                                                        songName: "HEARTBEAT",
                                                        songTabs: AlbumData().btsWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Dream Glow by BTS & Charli XCX":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().btsWorldDreamGlow,
                                                        songName: "DREAM GLOW",
                                                        songTabs: AlbumData().btsWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "A Brand New Day by BTS & Zara Larsson":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().btsWorldABrandNewDay,
                                                        songName: "A BRAND NEW DAY",
                                                        songTabs: AlbumData().btsWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "All Night by BTS & Juice WRLD":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().btsWorldAllNight,
                                                        songName: "ALL NIGHT",
                                                        songTabs: AlbumData().btsWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "LaLaLa by OKDAL":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().btsWorldLaLaLa,
                                                        songName: "LALALA",
                                                        songTabs: AlbumData().btsWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "You Are Here by Lee Hyun":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics:
                                                        AlbumData().btsWorldYouAreHere,
                                                        songName: "YOU ARE HERE",
                                                        songTabs: AlbumData().btsWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Voice)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmVoice,
                                                        songName: "????????? (VOICE)",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Do You":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmDoYou,
                                                        songName: "DO YOU",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Awakening)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmAwakening,
                                                        songName: "?????? (AWAKENING)",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Monster":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmMonster,
                                                        songName: "MONSTER",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Throw Away)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmThrowAway,
                                                        songName: "?????? (THROW AWAY)",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Joke)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmJoke,
                                                        songName: "?????? (JOKE)",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "God Rap":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmGodRap,
                                                        songName: "GOD RAP",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Rush (Ft. Krizz Kaliko)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmRush,
                                                        songName: "RUSH",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Life":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmLife,
                                                        songName: "LIFE",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Adrift)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmAdrift,
                                                        songName: "?????? (ADRIFT)",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "I Believe":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().rmIBelieve,
                                                        songName: "I BELIEVE",
                                                        songTabs: AlbumData().rmTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "tokyo":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics: AlbumData().monoTokyo,
                                                        songName: "TOKYO",
                                                        songTabs: AlbumData().monoTokyoTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "seoul":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().monoSeoul,
                                                        songName: "SEOUL",
                                                        songTabs: AlbumData().monoTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "moonchild":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().monoMoonchild,
                                                        songName: "MOONCHILD",
                                                        songTabs: AlbumData().monoTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "badbye(Ft. eAeon)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().monoBadbye,
                                                        songName: "BADBYE",
                                                        songTabs: AlbumData().monoTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (uhgood)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().monoUhgood,
                                                        songName: "?????? (UHGOOD)",
                                                        songTabs: AlbumData().monoTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (everythingoes) (Ft. NELL)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().monoEverythingoes,
                                                        songName: "????????? (EVERYTHINGOES)",
                                                        songTabs: AlbumData().monoTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "forever rain":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().monoForeverRain,
                                                        songName: "FOREEVR RAIN",
                                                        songTabs: AlbumData().monoTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro: Dt sugA (Ft. DJ Friz)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustdIntro,
                                                        songName: "INTRO: DT SUGA",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Agust D":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustdAgustd,
                                                        songName: "AGUST D",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Give It To Me":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustdGiveItToMe,
                                                        songName: "GIVE IT TO ME",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????????????????? (724148)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustd724148,
                                                        songName: "?????????????????? (724148)",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "140503 ????????? (140503 At Dawn)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustd140503AtDawn,
                                                        songName: "140503 ????????? (140503 AT DAWN)",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (The Last)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustdTheLast,
                                                        songName: "????????? (THE LAST)",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Tony Montana (Ft. Yankie)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustdTonyMontana,
                                                        songName: "TONY MONTANA",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Interlude: Dream, Reality":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsENG(
                                                        songLyrics: AlbumData().agustdInterlude,
                                                        songName: "INTERLUDE: DREAM, REALITY",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "So Far Away (Ft. SURAN (??????))":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().agustdSoFarAway,
                                                        songName: "SO FAR AWAY",
                                                        songTabs: AlbumData().agustdTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??? ??? (Moonlight)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2MoonLight,
                                                        songName: "??? ??? (MOONLIGHT)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Daechwita)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2Daechwita,
                                                        songName: "????????? (DAECHWITA)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ?????????? (What do you think?)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2WhatDoYouThink,
                                                        songName: "????????? ?????????? (WHAT DO YOU THINK?)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? ????????? (Strange) (ft. RM)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2Strange,
                                                        songName: "???????????? ????????? (STRANGE)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? ????????? ????????? (28) (Ft. NiiHWA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d228,
                                                        songName: "?????? ????????? ????????? (28)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Burn It (ft. MAX)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2BurnIt,
                                                        songName: "BURN",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (People)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2People,
                                                        songName: "?????? (PEOPLE)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Honsool)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2Honsool,
                                                        songName: "?????? (HONSOOL)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Interlude: Set me free":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2SetMeFree,
                                                        songName: "INTERLUDE: SET ME FREE",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? (Dear my friend) (Ft. Kim Jong Wan (?????????))":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().d2SetMeFree,
                                                        songName: "???????????? (DEAR MY FRIEND)",
                                                        songTabs: AlbumData().d2Tabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Hope World":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hopeWorldHopeWorld,
                                                        songName: "HOPE WORLD",
                                                        songTabs: AlbumData().hopeWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "P.O.P (Peace of Piece) Pt.1":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hopeWorldPOPPt1,
                                                        songName: "P.O.P (PEACE OF PIECE) PT.1",
                                                        songTabs: AlbumData().hopeWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Daydream (?????????)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hopeWorldDaydream,
                                                        songName: "DAYDREAM (?????????)",
                                                        songTabs: AlbumData().hopeWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Base Line":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hopeWorldBaseLine,
                                                        songName: "BASE LINE",
                                                        songTabs: AlbumData().hopeWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (HANGSANG) (Ft. Supreme Boi)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hopeWorldHangSang,
                                                        songName: "?????? (HANGSANG)",
                                                        songTabs: AlbumData().hopeWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Airplane":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hopeWorldAirplane,
                                                        songName: "AIRPLANE",
                                                        songTabs: AlbumData().hopeWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Blue Side (Outro)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().hopeWorldAirplane,
                                                        songName: "BLUE SIDE (OUTRO)",
                                                        songTabs: AlbumData().hopeWorldTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "We Are Bulletproof Pt. 1 (4 BEGINS Ruff)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "WE ARE BULLETPROOF PT. 1",
                                                            songLyrics: AlbumData().btsWAB1,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (I Know) by Rap Monster and Jungkook":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "????????? (I KNOW)",
                                                            songLyrics: AlbumData().btsIKnow,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Family Song (Wednesday) by BTS and GFRIEND":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "FAMILY SONG (WEDNESDAY)",
                                                            songLyrics: AlbumData().btsWednesday,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "BTS x JESSI":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "BTS x JESSI",
                                                            songLyrics: AlbumData().btsBtsJessi,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "So Far Away (SUGA, Jin & Jungkook Ver.)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "SO FAR AWAY",
                                                            songLyrics: AlbumData().btsSoFarAway,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "With Seoul":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "WITH SEOUL",
                                                            songLyrics: AlbumData().btsWithSeoul,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??? (Ddaeng)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "??? (DDAENG)",
                                                            songLyrics: AlbumData().btsDdaeng,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "You???re so Beautiful (LOTTE DUTY FREE x BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "YOU'RE SO BEAUTIFUL",
                                                            songLyrics: AlbumData().btsLdf,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "IONIQ: I'm On It (Hyundai x BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "IONIQ: I'M ON IT",
                                                            songLyrics: AlbumData().btsIoniq,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "In The SOOP":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "IN THE SOOP",
                                                            songLyrics: AlbumData().btsinTheSoop,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Scenery)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "?????? (SCENERY)",
                                                            songLyrics: AlbumData().vScenery,
                                                            songTabs: AlbumData().vOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Winter Bear":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "WINTER BEAR",
                                                            songLyrics: AlbumData().vWinterBear,
                                                            songTabs: AlbumData().vSongsEngTab,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Sweet Night":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "SWEET NIGHT",
                                                            songLyrics: AlbumData().vSweetNight,
                                                            songTabs: AlbumData().vSongsEngTab,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Snow Flower (ft. Peakboy)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "SNOW FLOWER",
                                                            songLyrics: AlbumData().vSnowFlower,
                                                            songTabs: AlbumData().vOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Song Request) (Lee Sora ft. SUGA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "????????? (SONG REQUEST)",
                                                        songLyrics: AlbumData().sugaSongRequest,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Halsey, SUGA - SUGA???s Interlude":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "SUGA???s INTERLUDE",
                                                        songLyrics: AlbumData().sugaSugasInterlude,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "IU (?????????) - eight (??????) (Prod. & ft. SUGA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "EIGHT (??????)",
                                                        songLyrics: AlbumData().sugaEight,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Blueberry Eyes (MAX ft. SUGA)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "BLUEBERRY EYES",
                                                        songLyrics: AlbumData().sugaEight,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Born Singer":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "BORN SINGER",
                                                            songLyrics: AlbumData().btsBornSinger,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Beautiful":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "BEAUTIFUL",
                                                            songLyrics: AlbumData().btsBeautiful,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "95 Graduation by V and Jimin":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "95 GRADUATION",
                                                            songLyrics: AlbumData().bts95Graduation,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "So 4 More":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "SO 4 MORE",
                                                            songLyrics: AlbumData().btsSo4More,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "???????????? (Working)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "???????????? (WORKING)",
                                                            songLyrics: AlbumData().jungkookWorking,
                                                            songTabs: AlbumData().jungkookOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Christmas Day by Jimin and Jungkook":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "CHRISTMAS DAY",
                                                            songLyrics: AlbumData().btsChristmasDay,
                                                            songTabs: AlbumData().btsOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "My Universe":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songLyrics: AlbumData().myUniverse,
                                                        songName: "MY UNIVERSE",
                                                        songTabs: AlbumData().myUniverseAlbumTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "??MI - You (Prod. SUGA of BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsJP(
                                                        songName: "YOU",
                                                        songLyrics: AlbumData().sugaYou,
                                                        songTabs: AlbumData().sugaYouTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Yours":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "YOURS",
                                                        songLyrics: AlbumData().jinYours,
                                                        songTabs: AlbumData().jinOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? ?????? (Super Tuna)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "?????? ?????? (SUPER TUNA)",
                                                        songLyrics: AlbumData().jinSuperTuna,
                                                        songTabs: AlbumData().jinOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Juice WRLD - Girl Of My Dreams (with Suga from BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "JUICE WRLD - GIRL OF MY DREAMS",
                                                        songLyrics: AlbumData().sugaGirlOfMyDreams,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Christmas Tree":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "CHRISTMAS TREE",
                                                            songLyrics: AlbumData().vChristmasTree,
                                                            songTabs: AlbumData().vOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Stay Alive (Prod. SUGA of BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "STAY ALIVE",
                                                            songLyrics: AlbumData().jungkookStayAlive,
                                                            songTabs: AlbumData().jungkookOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "With You (Jimin x Ha Sung Woon)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "WITH YOU",
                                                            songLyrics: AlbumData().jiminWithYou,
                                                            songTabs: AlbumData().jiminOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "PSY - That That (prod. & ft. SUGA of BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => LyricsKR(
                                                        songName: "THAT THAT",
                                                        songLyrics: AlbumData().sugaThatThat,
                                                        songTabs: AlbumData().sugaOtherSongsTabs,
                                                        songFullName: item,
                                                      ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Yet To Come":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "YET TO COME",
                                                            songLyrics: AlbumData().proofYetToCome,
                                                            songTabs: AlbumData().proofTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ?????? (Run BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "????????? ?????? (RUN BTS)",
                                                            songLyrics: AlbumData().proofRunBTS,
                                                            songTabs: AlbumData().proofTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "For Youth":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "FOR YOUTH",
                                                            songLyrics: AlbumData().proofForYouth,
                                                            songTabs: AlbumData().proofTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? ?????? (Young Love)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "????????? ?????? (YOUNG LOVE)",
                                                            songLyrics: AlbumData().proofYoungLove,
                                                            songTabs: AlbumData().proofTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "????????? (Quotation Mark)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "????????? (QUOTATION MARK)",
                                                            songLyrics: AlbumData().proofQuotationMark,
                                                            songTabs: AlbumData().proofTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Tony Montana (with Jimin)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "TONY MONTANA",
                                                            songLyrics: AlbumData().proofTonyMontanaWithJimin,
                                                            songTabs: AlbumData().proofTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "My You":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "MY YOU",
                                                            songLyrics: AlbumData().jungkookMyYou,
                                                            songTabs: AlbumData().jungkookOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Charlie Puth - Left And Right (ft. Jungkook of BTS)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "Left and Right",
                                                            songLyrics: AlbumData().jungkookLeftAndRight,
                                                            songTabs: AlbumData().jungkookEngTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "MORE":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "MORE",
                                                            songLyrics: AlbumData().jhopeMore,
                                                            songTabs: AlbumData().jhopeOtherSongsTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Intro":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsENG(
                                                            songName: "INTRO",
                                                            songLyrics: AlbumData().jackInTheBoxIntro,
                                                            songTabs: const [1, 0, 0, 0],
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Pandora's Box":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "PANDORA'S BOX",
                                                            songLyrics: AlbumData().jackInTheBoxPandorasBox,
                                                            songTabs: AlbumData().jackInTheBoxTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "STOP (????????? ?????? ????????? ??????)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "STOP (????????? ?????? ????????? ??????)",
                                                            songLyrics: AlbumData().jackInTheBoxStop,
                                                            songTabs: AlbumData().jackInTheBoxTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "= (Equal Sign)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "= (EQUAL SIGN)",
                                                            songLyrics: AlbumData().jackInTheBoxEqualSign,
                                                            songTabs: AlbumData().jackInTheBoxTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "What if...":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "WHAT IF...",
                                                            songLyrics: AlbumData().jackInTheBoxWhatIf,
                                                            songTabs: AlbumData().jackInTheBoxTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Safety Zone":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "SAFETY ZONE",
                                                            songLyrics: AlbumData().jackInTheBoxSafetyZone,
                                                            songTabs: AlbumData().jackInTheBoxTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "Future":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "FUTURE",
                                                            songLyrics: AlbumData().jackInTheBoxFuture,
                                                            songTabs: AlbumData().jackInTheBoxTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
                                                break;
                                              case "?????? (Arson)":
                                                {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LyricsKR(
                                                            songName: "?????? (ARSON)",
                                                            songLyrics: AlbumData().jackInTheBoxArson,
                                                            songTabs: AlbumData().jackInTheBoxTabs,
                                                            songFullName: item,
                                                          ),
                                                    ),
                                                  ).then((value) => setState(() {}));
                                                }
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
                      Text("Nothing here  ~.~", style: GoogleFonts.openSans(fontSize: 18, fontStyle: FontStyle.italic),),
                      const SizedBox(height: 20),
                      Text("Add your favorite songs by clicking on the heart icon in lyrics screen", textAlign: TextAlign.center, style: GoogleFonts.openSans(fontSize: 18, fontStyle: FontStyle.italic),),
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
