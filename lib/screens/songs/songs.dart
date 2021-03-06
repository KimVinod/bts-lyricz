import 'package:bts_lyrics_app/data/album_data.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_eng.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_jp.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_kr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class Songs extends StatelessWidget {
  final List? songNames;
  final String? albumName;
  final String? albumArt;

  const Songs({Key? key ,this.songNames, this.albumName, this.albumArt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text("Songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        backgroundColor: appBarColor,
      ),
      body: Material(
        color: appUILightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 15),
            Center(
              child: Column(
                children: <Widget>[
                  Material(
                      elevation: 3,
                      shadowColor: Colors.purple.shade700,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 150,
                        height: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage(albumArt!), fit: BoxFit.fill)
                        ),
                      )),
                  const SizedBox(height: 4),
                  Text(
                    albumName!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Songs",
                style: GoogleFonts.openSans(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Card(
                    elevation: 3,
                    shadowColor: Colors.purple.shade700,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: const Color.fromRGBO(152, 105, 190, 1),
                    child: RawScrollbar(
                      thumbColor: const Color.fromRGBO(130, 70, 190, 1),
                      thickness: 5.0,
                      radius: const Radius.circular(15.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                            color: Colors.black, height: 1, thickness: 0.6),
                        itemCount: songNames!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            title: Text(
                              songNames![index],
                              style: GoogleFonts.openSans(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              switch (songNames![index]) {
                                case "Permission to Dance":
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LyricsENG(
                                          songLyrics: AlbumData().ptdLyrics,
                                          songName: "PERMISSION TO DANCE",
                                          songTabs: AlbumData().butterPtdAlbumTabs,
                                          songFullName: songNames![index],
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
                                          songTabs: AlbumData().butterAlbumTabs,
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songName: "BEST OF ME",
                                          songTabs: AlbumData().lyHerTabs,
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
                                  }
                                  break;
                                case "???????????? Go (Go Go)":
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LyricsKR(
                                          songLyrics: AlbumData().lyHerGoGo,
                                          songName: "???????????? GO (GO GO)",
                                          songTabs: AlbumData().lyHerTabs,
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songTabs: AlbumData().mots7Tabs,
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                           songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songTabs: AlbumData().btsTheBestTabs,
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
                                        ),
                                      ),
                                    );
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                          songTabs: AlbumData().butterRemixAlbumTabs,
                                          songFullName: songNames![index],
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
                                          songFullName: songNames![index],
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
                                            ),
                                      ),
                                    );
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
                                            ),
                                      ),
                                    );
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
                                              songFullName: songNames![index],
                                            ),
                                      ),
                                    );
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
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
                                              songTabs: AlbumData().jackInTheBoxTabs,
                                              songFullName: songNames![index],
                                            ),
                                      ),
                                    );
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
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
                                              songFullName: songNames![index],
                                            ),
                                      ),
                                    );
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
                                              songFullName: songNames![index],
                                            ),
                                      ),
                                    );
                                  }
                                  break;
                              }
                            },
                          );
                        },
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
