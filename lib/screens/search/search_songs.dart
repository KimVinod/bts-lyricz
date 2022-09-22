import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:bts_lyrics_app/screens/search/search_widget.dart';
import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class SearchSongs extends StatefulWidget {
  const SearchSongs({Key? key}) : super(key: key);


  @override
  SearchSongsState createState() => SearchSongsState();
}

class SearchSongsState extends State<SearchSongs> {
  late List<Song> songs;
  String query = "";

  @override
  void initState() {
    super.initState();
    songs = allSongs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text("Search songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        backgroundColor: appBarColor,

      ),
      body: Material(
        color: appUILightColor,
        child: Column(
          children: [
            buildSearch(),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll){
                overScroll.disallowIndicator();
                return true;
              },
              child: Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                        song.name,
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
                                      switch (song.name) {
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "약속 (Promise)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "약속 (PROMISE)",
                                                      songLyrics: AlbumData().jiminPromise,
                                                      songTabs: AlbumData().jiminOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "이 밤 (Tonight)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "이 밤 (TONIGHT)",
                                                      songLyrics: AlbumData().jinTonight,
                                                      songTabs: AlbumData().jinOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "부끄부끄 (Buckubucku) (MFBTY ft. EE, RM and Dino-J)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "부끄부끄 (Buckubucku)",
                                                      songLyrics: AlbumData().rmBuckubucku,
                                                      songTabs: AlbumData().rmOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "U (Primary ft. 권진아 Kwon Jin Ah, Rap Monster)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "U",
                                                      songLyrics: AlbumData().rmU,
                                                      songTabs: AlbumData().rmOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Gajah (코끼리) (Gaeko (개코) ft. Rap Monster)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "GAJAH (코끼리)",
                                                      songLyrics: AlbumData().rmGajah,
                                                      songTabs: AlbumData().rmOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Crying Over You ◐ (Remix) (HONNE ft. RM & BEKA)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsENG(
                                                      songName: "CRYING OVER YOU ◐ (REMIX)",
                                                      songLyrics: AlbumData().rmCryingOverYou,
                                                      songTabs: AlbumData().rmCryingOverYouTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Winter Flower (雪中梅) (YOUNHA (윤하) ft. RM)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "WINTER FLOWER (雪中梅)",
                                                      songLyrics: AlbumData().rmWinterFlower,
                                                      songTabs: AlbumData().rmOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "그러지 마 (Don’t) (eAeon (이이언) ft. RM)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "그러지 마 (DON’T)",
                                                      songLyrics: AlbumData().rmDont,
                                                      songTabs: AlbumData().rmOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "좋아요 (Like)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().twoCool4SkoolLike,
                                                  songName: "좋아요 (LIKE)",
                                                  songTabs:
                                                  AlbumData().twoCool4SkoolTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "길 (Road/Path)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().twoCool4SkoolPath,
                                                  songName: "길 (ROAD/PATH)",
                                                  songTabs:
                                                  AlbumData().twoCool4SkoolTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "진격의 방탄 (Attack on Bangtan)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().orul82AttackOnBangtan,
                                                  songName:
                                                  "진격의 방탄 (ATTACK ON BANGTAN)",
                                                  songTabs: AlbumData().orul82Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "팔도강산 (Paldogangsan)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().orul82Paldogangsan,
                                                  songName: "팔도강산 (PALDOGANGSAN)",
                                                  songTabs: AlbumData().orul82Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "상남자 (Boy in Luv)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .skoolLuvAffairBoyInLuv,
                                                  songName: "상남자 (BOY IN LUV)",
                                                  songTabs:
                                                  AlbumData().skoolLuvAffairTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "어디에서 왔는지 (Where You From)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .skoolLuvAffairWhereYouFrom,
                                                  songName: "어디에서 왔는지 (WHERE YOU FROM)",
                                                  songTabs:
                                                  AlbumData().skoolLuvAffairTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "하루만 (Just One Day)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .skoolLuvAffairJustOneDay,
                                                  songName: "하루만 (JUST ONE DAY)",
                                                  songTabs:
                                                  AlbumData().skoolLuvAffairTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "등골브레이커 (Spine Breaker)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .skoolLuvAffairSpineBreaker,
                                                  songName: "등골브레이커 (SPINE BREAKER)",
                                                  songTabs:
                                                  AlbumData().skoolLuvAffairTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "호르몬 전쟁 (War of Hormone)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .darkAndWildWarOfHormone,
                                                  songName: "호르몬 전쟁 (WAR OF HORMONE)",
                                                  songTabs: AlbumData().darkAndWildTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "힙합성애자 (Hip Hop Phile)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .darkAndWildHipHopePhile,
                                                  songName: "힙합성애자 (HIP HOP PHILE)",
                                                  songTabs: AlbumData().darkAndWildTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "핸드폰 좀 꺼줄래 (Could You Turn off Your Cell Phone?)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().darkAndWildCellphone,
                                                  songName:
                                                  "핸드폰 좀 꺼줄래 (COULD YOU TURN OFF YOUR CELLPHONE)?)",
                                                  songTabs: AlbumData().darkAndWildTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "이불킥 (Embarrassed)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .darkAndWildEmbarrassed,
                                                  songName: "이불킥 (EMBARRASSED)",
                                                  songTabs: AlbumData().darkAndWildTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "2학년 (Second Grade)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .darkAndWildSecondGrade,
                                                  songName: "2학년 (SECOND GRADE)",
                                                  songTabs: AlbumData().darkAndWildTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Outro: 그게 말이 돼? (Do You Think It Makes Sense?)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .darkAndWildSecondGrade,
                                                  songName:
                                                  "OUTRO: 그게 말이 돼? (DO YOU THINK IT MAKES SENSE?)",
                                                  songTabs: AlbumData().darkAndWildTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Intro: 화양연화 (The Most Beautiful Moment in Life)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().hyyh1Intro,
                                                  songName:
                                                  "Intro: 화양연화 (THE MOST BEAUTIFUL MOMENT IN LIFE)",
                                                  songTabs: AlbumData().hyyh1Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "잡아줘 (Hold Me Tight)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().hyyh1HoldMeTight,
                                                  songName: "잡아줘 (HOLD ME TIGHT)",
                                                  songTabs: AlbumData().hyyh1Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "쩔어 (Dope)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().hyyh1Dope,
                                                  songName: "쩔어 (DOPE)",
                                                  songTabs: AlbumData().hyyh1Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "흥탄소년단 (Boyz with Fun)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().hyyh1BoyzWithFun,
                                                  songName: "흥탄소년단 (BOYZ WITH FUN)",
                                                  songTabs: AlbumData().hyyh1Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "이사 (Moving On)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().hyyh1MovingOn,
                                                  songName: "이사 (MOVING ON)",
                                                  songTabs: AlbumData().hyyh1Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "뱁새 (Silver Spoon)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().hyyh2SilverSpoon,
                                                  songName: "뱁새 (SILVER SPOON)",
                                                  songTabs: AlbumData().hyyh2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "고엽 (Autumn Leaves)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().hyyh2AutumnLeaves,
                                                  songName: "고엽 (AUTUMN LEAVES)",
                                                  songTabs: AlbumData().hyyh2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Fire (불타오르네)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().youngForeverFire,
                                                  songName: "FIRE (불타오르네)",
                                                  songTabs:
                                                  AlbumData().youngForeverTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "피 땀 눈물 (Blood Sweat & Tears)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().wingsIntro,
                                                  songName:
                                                  "피 땀 눈물 (BLOOD SWEAT & TEARS)",
                                                  songTabs: AlbumData().wingsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "21세기 소녀 (21st Century Girl)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().wings21CenturyGirls,
                                                  songName:
                                                  "21세기 소녀 (21ST CENTURY GIRL)",
                                                  songTabs: AlbumData().wingsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "둘! 셋! (2! 3!)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().wings23,
                                                  songName: "둘! 셋! (2! 3!)",
                                                  songTabs: AlbumData().wingsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "봄날 (Spring Day)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().ynwaSpringDay,
                                                  songName: "봄날 (SPRING DAY)",
                                                  songTabs: AlbumData().ynwaTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Intro: Serendipity (세렌디피티)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().lyHerIntro,
                                                  songName:
                                                  "INTRO: SERENDIPITY (세렌디피티)",
                                                  songTabs: AlbumData().lyHerTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "보조개 (dimple)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().lyHerDimple,
                                                  songName: "보조개 (DIMPLE)",
                                                  songTabs: AlbumData().lyHerTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "고민보다 Go (Go Go)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().lyHerGoGo,
                                                  songName: "고민보다 Go (GO GO)",
                                                  songTabs: AlbumData().lyHerTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "바다 (Sea)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().lyHerSea,
                                                  songName: "바다 (SEA)",
                                                  songTabs: AlbumData().lyHerTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "전하지 못한 진심 (The Truth Untold)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().lyTearTTU,
                                                  songName:
                                                  "전하지 못한 진심 (THE TRUTH UNTOLD)",
                                                  songTabs: AlbumData().lyTearTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "낙원 (Paradise)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().lyTearParadise,
                                                  songName: "낙원 (PARADISE)",
                                                  songTabs: AlbumData().lyTearTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Trivia 起: Just Dance":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().lyAnswerJustDance,
                                                  songName: "TRIVIA 起: JUST DANCE",
                                                  songTabs: AlbumData().lyAnswerTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Trivia 承: Love":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().lyAnswerLove,
                                                  songName: "TRIVIA 承: LOVE",
                                                  songTabs: AlbumData().lyAnswerTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Trivia 轉: Seesaw":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().lyAnswerSeesaw,
                                                  songName: "TRIVIA 轉: SEESAW",
                                                  songTabs: AlbumData().lyAnswerTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "작은 것들을 위한 시 (Boy With Luv)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().motsPersonaBWL,
                                                  songName:
                                                  "작은 것들을 위한 시 (BOY WITH LUV)",
                                                  songTabs: AlbumData().motsPersonaTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "소우주 (Mikrokosmos)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData()
                                                      .motsPersonaMikrokosmos,
                                                  songName: "소우주 (MIKROKOSMOS)",
                                                  songTabs: AlbumData().motsPersonaTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "시차 (My Time)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().mots7MyTime,
                                                  songName: "시차 (MY TIME)",
                                                  songTabs: AlbumData().mots7Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "욱 (UGH!)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().mots7Ugh,
                                                  songName: "욱 (UGH!)",
                                                  songTabs: AlbumData().mots7Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "00:00 (Zero O’Clock)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().mots7ZeroOClock,
                                                  songName: "00:00 (ZERO O'CLOCK)",
                                                  songTabs: AlbumData().mots7Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "친구 (Friends)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().mots7Friends,
                                                  songName: "친구 (FRIENDS)",
                                                  songTabs: AlbumData().mots7Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "いいね! (I Like It) (Japanese Ver.)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics:
                                                  AlbumData().noMoreDreamILikeIt,
                                                  songName: "いいね! (I LIKE IT)",
                                                  songTabs: AlbumData().noMoreDreamTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "進撃の防弾 (Attack on Bangtan) (Japanese Ver.)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics: AlbumData()
                                                      .noMoreDreamAttackOnBangtan,
                                                  songName: "進撃の防弾 (ATTACK ON BANGTAN)",
                                                  songTabs: AlbumData().noMoreDreamTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "いいね! Pt.2 ～あの場所で～ (I Like It Pt.2)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics:
                                                  AlbumData().wakeUpILikeItPt2,
                                                  songName:
                                                  "いいね! PT.2 ～あの場所で～ (I LIKE IT PT.2)",
                                                  songTabs: AlbumData().wakeUpTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "ホルモン戦争 (War of Hormone) (Japanese Ver.)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics:
                                                  AlbumData().forYouWarOfHormone,
                                                  songName: "ホルモン戦争 (WAR OF HORMONE)",
                                                  songTabs: AlbumData().forYouTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Dope -超ヤベー!- (Japanese Ver.)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics: AlbumData().iNeedUDope,
                                                  songName: "DOPE -超ヤベー!-",
                                                  songTabs: AlbumData().iNeedUTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "フンタン少年団 (Boyz With Fun) (Japanese Ver.)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics:
                                                  AlbumData().iNeedUBoyzWithFun,
                                                  songName: "フンタン少年団 (BOYZ WITH FUN)",
                                                  songTabs: AlbumData().iNeedUTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "ペップセ (Silver Spoon) (Japanese Ver.)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics:
                                                  AlbumData().youthSilverSpoon,
                                                  songName: "ペップセ (SILVER SPOON)",
                                                  songTabs: AlbumData().youthTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "血、汗、淚 (Blood Sweat & Tears (Japanese Ver.)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songLyrics: AlbumData().bstBST,
                                                  songName:
                                                  "血、汗、淚 (Blood Sweat & Tears)",
                                                  songTabs: AlbumData().bstTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "여기 봐 (Look Here)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().darkAndWildLookHere,
                                                  songName: "여기 봐 (LOOK HERE)",
                                                  songTabs: AlbumData().darkAndWildTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "목소리 (Voice)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().rmVoice,
                                                  songName: "목소리 (VOICE)",
                                                  songTabs: AlbumData().rmTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "각성 (Awakening)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().rmAwakening,
                                                  songName: "각성 (AWAKENING)",
                                                  songTabs: AlbumData().rmTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "버려 (Throw Away)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().rmThrowAway,
                                                  songName: "버려 (THROW AWAY)",
                                                  songTabs: AlbumData().rmTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "농담 (Joke)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().rmJoke,
                                                  songName: "농담 (JOKE)",
                                                  songTabs: AlbumData().rmTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "표류 (Adrift)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().rmAdrift,
                                                  songName: "표류 (ADRIFT)",
                                                  songTabs: AlbumData().rmTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "어긋 (uhgood)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().monoUhgood,
                                                  songName: "어긋 (UHGOOD)",
                                                  songTabs: AlbumData().monoTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "지나가 (everythingoes) (Ft. NELL)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().monoEverythingoes,
                                                  songName: "지나가 (EVERYTHINGOES)",
                                                  songTabs: AlbumData().monoTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "치리사일사팔 (724148)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().agustd724148,
                                                  songName: "치리사일사팔 (724148)",
                                                  songTabs: AlbumData().agustdTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "140503 새벽에 (140503 At Dawn)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().agustd140503AtDawn,
                                                  songName: "140503 새벽에 (140503 AT DAWN)",
                                                  songTabs: AlbumData().agustdTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "마지막 (The Last)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().agustdTheLast,
                                                  songName: "마지막 (THE LAST)",
                                                  songTabs: AlbumData().agustdTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "So Far Away (Ft. SURAN (수란))":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().agustdSoFarAway,
                                                  songName: "SO FAR AWAY",
                                                  songTabs: AlbumData().agustdTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "저 달 (Moonlight)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d2MoonLight,
                                                  songName: "저 달 (MOONLIGHT)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "대취타 (Daechwita)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d2Daechwita,
                                                  songName: "대취타 (DAECHWITA)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "어떻게 생각해? (What do you think?)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d2WhatDoYouThink,
                                                  songName: "어떻게 생각해? (WHAT DO YOU THINK?)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "이상하지 않은가 (Strange) (ft. RM)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d2Strange,
                                                  songName: "이상하지 않은가 (STRANGE)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "점점 어른이 되나봐 (28) (Ft. NiiHWA)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d228,
                                                  songName: "점점 어른이 되나봐 (28)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "사람 (People)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d2People,
                                                  songName: "사람 (PEOPLE)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "혼술 (Honsool)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d2Honsool,
                                                  songName: "혼술 (HONSOOL)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "어땠을까 (Dear my friend) (Ft. Kim Jong Wan (김종완))":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().d2SetMeFree,
                                                  songName: "어땠을까 (DEAR MY FRIEND)",
                                                  songTabs: AlbumData().d2Tabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Daydream (백일몽)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().hopeWorldDaydream,
                                                  songName: "DAYDREAM (백일몽)",
                                                  songTabs: AlbumData().hopeWorldTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "항상 (HANGSANG) (Ft. Supreme Boi)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics: AlbumData().hopeWorldHangSang,
                                                  songName: "항상 (HANGSANG)",
                                                  songTabs: AlbumData().hopeWorldTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "알아요 (I Know) by Rap Monster and Jungkook":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "알아요 (I KNOW)",
                                                      songLyrics: AlbumData().btsIKnow,
                                                      songTabs: AlbumData().btsOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "땡 (Ddaeng)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "땡 (DDAENG)",
                                                      songLyrics: AlbumData().btsDdaeng,
                                                      songTabs: AlbumData().btsOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "You’re so Beautiful (LOTTE DUTY FREE x BTS)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "YOU'RE SO BEAUTIFUL",
                                                      songLyrics: AlbumData().btsLdf,
                                                      songTabs: AlbumData().btsOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "풍경 (Scenery)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "풍경 (SCENERY)",
                                                      songLyrics: AlbumData().vScenery,
                                                      songTabs: AlbumData().vOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "신청곡 (Song Request) (Lee Sora ft. SUGA)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songName: "신청곡 (SONG REQUEST)",
                                                  songLyrics: AlbumData().sugaSongRequest,
                                                  songTabs: AlbumData().sugaOtherSongsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Halsey, SUGA - SUGA’s Interlude":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songName: "SUGA’s INTERLUDE",
                                                  songLyrics: AlbumData().sugaSugasInterlude,
                                                  songTabs: AlbumData().sugaOtherSongsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "IU (아이유) - eight (에잇) (Prod. & ft. SUGA)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songName: "EIGHT (에잇)",
                                                  songLyrics: AlbumData().sugaEight,
                                                  songTabs: AlbumData().sugaOtherSongsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "일하는중 (Working)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "일하는중 (WORKING)",
                                                      songLyrics: AlbumData().jungkookWorking,
                                                      songTabs: AlbumData().jungkookOtherSongsTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "ØMI - You (Prod. SUGA of BTS)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsJP(
                                                  songName: "YOU",
                                                  songLyrics: AlbumData().sugaYou,
                                                  songTabs: AlbumData().sugaYouTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "슈퍼 참치 (Super Tuna)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songName: "슈퍼 참치 (SUPER TUNA)",
                                                  songLyrics: AlbumData().jinSuperTuna,
                                                  songTabs: AlbumData().jinOtherSongsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "달려라 방탄 (Run BTS)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "달려라 방탄 (RUN BTS)",
                                                      songLyrics: AlbumData().proofRunBTS,
                                                      songTabs: AlbumData().proofTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "애매한 사이 (Young Love)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "애매한 사이 (YOUNG LOVE)",
                                                      songLyrics: AlbumData().proofYoungLove,
                                                      songTabs: AlbumData().proofTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "따옴표 (Quotation Mark)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "따옴표 (QUOTATION MARK)",
                                                      songLyrics: AlbumData().proofQuotationMark,
                                                      songTabs: AlbumData().proofTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "STOP (세상에 나쁜 사람은 없다)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "STOP (세상에 나쁜 사람은 없다)",
                                                      songLyrics: AlbumData().jackInTheBoxStop,
                                                      songTabs: AlbumData().jackInTheBoxTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
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
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "방화 (Arson)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LyricsKR(
                                                      songName: "방화 (ARSON)",
                                                      songLyrics: AlbumData().jackInTheBoxArson,
                                                      songTabs: AlbumData().jackInTheBoxTabs,
                                                      songFullName: song.name,
                                                    ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Bad Decisions":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsENG(
                                                  songLyrics:
                                                  AlbumData().btsBadDecisions,
                                                  songName: "BAD DECISIONS",
                                                  songTabs: AlbumData().btsENGSinglesTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "SEXY NUKIM (섹시느낌) (Balming Tiger ft. RM of BTS)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().rmSexyNukim,
                                                  songName: "SEXY NUKIM (섹시느낌)",
                                                  songTabs: AlbumData().rmOtherSongsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
                                          }
                                          break;
                                        case "Rush Hour (Crush (크러쉬) ft. j-hope of BTS)":
                                          {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LyricsKR(
                                                  songLyrics:
                                                  AlbumData().rmSexyNukim,
                                                  songName: "RUSH HOUR",
                                                  songTabs: AlbumData().jhopeOtherSongsTabs,
                                                  songFullName: song.name,
                                                ),
                                              ),
                                            );
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    onChanged: searchSongs,
    hintText: 'Search here',
  );

  void searchSongs(String query) {
    final songs = allSongs.where((song) {
      final songName = song.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return songName.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.songs = songs;
    });
  }
}
