import 'package:bts_lyrics_app/screens/discography/albums_screen.dart';
import 'package:bts_lyrics_app/screens/discography/digital_singles.dart';
import 'package:bts_lyrics_app/screens/member/member_screen.dart';
import 'package:bts_lyrics_app/utils/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

const Color appUILightColor = Color.fromRGBO(180, 136, 212, 1);
const Color appUIDarkColor = Color.fromRGBO(91, 50, 120, 1);
const Color appBarColor = Color.fromRGBO(150, 86, 190, 1);
const Color appCardColor = Color.fromRGBO(152, 105, 190, 1);
const Color appThumbBarColor = Color.fromRGBO(130, 70, 190, 1);
const Color appOffBlackColor = Color(0xff262626);

ThemeData getLightTheme({required bool isMaterialYou, ColorScheme? lightColorScheme}) {
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          allowEnterRouteSnapshotting: false,
        ),
      },
    ),
    splashColor: appUILightColor.withValues(alpha: 0.1),
    focusColor: appUILightColor.withValues(alpha: 0.08),
    hoverColor: appUILightColor.withValues(alpha: 0.1),
    colorScheme: isMaterialYou ? lightColorScheme ?? MaterialTheme.lightScheme().toColorScheme() : MaterialTheme.lightScheme().toColorScheme(),
  );
}

ThemeData getDarkTheme({required bool isMaterialYou, ColorScheme? darkColorScheme}) {
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          allowEnterRouteSnapshotting: false,
        ),
      },
    ),
    colorScheme: isMaterialYou ? darkColorScheme ?? MaterialTheme.darkScheme().toColorScheme() : MaterialTheme.darkScheme().toColorScheme(),
  );
}

(ColorScheme light, ColorScheme dark) generateDynamicColourSchemes(ColorScheme lightDynamic, ColorScheme darkDynamic) {
  var lightBase = ColorScheme.fromSeed(seedColor: lightDynamic.primary);
  var darkBase = ColorScheme.fromSeed(seedColor: darkDynamic.primary, brightness: Brightness.dark);

  var lightAdditionalColours = _extractAdditionalColours(lightBase);
  var darkAdditionalColours = _extractAdditionalColours(darkBase);

  var lightScheme = _insertAdditionalColours(lightBase, lightAdditionalColours);
  var darkScheme = _insertAdditionalColours(darkBase, darkAdditionalColours);

  return (lightScheme.harmonized(), darkScheme.harmonized());
}

List<Color> _extractAdditionalColours(ColorScheme scheme) => [
  scheme.surface,
  scheme.surfaceDim,
  scheme.surfaceBright,
  scheme.surfaceContainerLowest,
  scheme.surfaceContainerLow,
  scheme.surfaceContainer,
  scheme.surfaceContainerHigh,
  scheme.surfaceContainerHighest,
];

ColorScheme _insertAdditionalColours(ColorScheme scheme, List<Color> additionalColours) => scheme.copyWith(
  surface: additionalColours[0],
  surfaceDim: additionalColours[1],
  surfaceBright: additionalColours[2],
  surfaceContainerLowest: additionalColours[3],
  surfaceContainerLow: additionalColours[4],
  surfaceContainer: additionalColours[5],
  surfaceContainerHigh: additionalColours[6],
  surfaceContainerHighest: additionalColours[7],
);

const String shareText = "Hey! Check this out. Get all the song lyrics of BTS in one place.\n\nApp name: Bangtan Lyricz\n\nGoogle Play Store:\n$playStoreUrl";
const String versionNotesUrl = "https://sites.google.com/view/bts-lyricz-ver";
const String twitterUrl = "https://twitter.com/intent/user?user_id=3249582416";
const String playStoreUrl = "https://play.google.com/store/apps/details?id=com.kimvinod.bts_lyricz";
const String githubUrl = "https://github.com/KimVinod/bts-lyricz";
const String email = "vinoddevendran34@gmail.com";

enum GameState {
  notReady,
  ready,
  playing,
  correct,
  incorrect,
}

String getBt21Pic() {
  final List<String> bt21Pics = [
    "images/bt21/koya.png",
    "images/bt21/rj.png",
    "images/bt21/shooky.png",
    "images/bt21/mang.png",
    "images/bt21/chimmy.png",
    "images/bt21/tata.png",
    "images/bt21/cooky.png",
  ];

  bt21Pics.shuffle();
  return bt21Pics.first;
}

const Map<String, Widget> discography = {
  'images/digital-singles.jpg': DigitalSingles(isUnOfficial: false, isArmy: false),
  'images/kr-albums.jpg': Albums(type: 'kr'),
  'images/jp-albums.jpg': Albums(type: 'jp'),
  'images/uo-albums.jpg': Albums(type: 'uo'),
  'images/uo-songs2.jpg': DigitalSingles(isUnOfficial: true, isArmy: false),
  'images/army-songs.jpg': DigitalSingles(isUnOfficial: true, isArmy: true),
};

const List<Map<String, dynamic>> soloProjects = [
  {
    'imageAsset': 'images/members/joon.jpg',
    'name': 'RM',
    'widget': Member(memberName: "RM", dataKey: 'namjoon'),
  },
  {
    'imageAsset': 'images/members/jin.jpg',
    'name': 'Jin',
    'widget': Member(memberName: "Jin", dataKey: 'seokjin'),
  },
  {
    'imageAsset': 'images/members/yoongi.jpg',
    'name': 'SUGA / Agust D',
    'widget': Member(memberName: "SUGA / Agust D", dataKey: 'yoongi'),
  },
  {
    'imageAsset': 'images/members/hobi.jpg',
    'name': 'j-hope',
    'widget': Member(memberName: "j-hope", dataKey: 'hoseok'),
  },
  {
    'imageAsset': 'images/members/jimin.jpg',
    'name': 'Jimin',
    'widget': Member(memberName: "Jimin", dataKey: 'jimin'),
  },
  {
    'imageAsset': 'images/members/tae.jpg',
    'name': 'V',
    'widget': Member(memberName: "V", dataKey: 'taehyung'),
  },
  {
    'imageAsset': 'images/members/jk.jpg',
    'name': 'Jungkook',
    'widget': Member(memberName: "Jungkook", dataKey: 'jungkook'),
  },

];

void showToastError() => Fluttertoast.showToast(
  msg: "Error occurred. Your phone doesn't support opening links",
  toastLength: Toast.LENGTH_SHORT,
);

Container buildNA(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(getBt21Pic(), height: MediaQuery.sizeOf(context).height * 0.25),
        const SizedBox(height: 10),
        Text(
          "not available >.<",
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget buildTabContent({required BuildContext context, required String name, String? lyrics, required String releaseDate}) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding:
      const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: lyrics != null
          ? SingleChildScrollView(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
            Text(
              name,
              style: GoogleFonts.openSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Released: $releaseDate",
              style: GoogleFonts.openSans(fontSize: 14.0),
            ),
            const SizedBox(height: 24.0),
            SelectableText(
              lyrics,
              style: GoogleFonts.openSans(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
                    ],
                  ),
          )
          : buildNA(context),
    ),
  );
}

const List<Map<String, dynamic>> krAlbums = [
  {
    'album':'2 Cool 4 Skool',
    'imageAsset':'images/2cool4skool.jpg',
  },
  {
    'album':'O!RUL8,2?',
    'imageAsset':'images/o!rul8,2.jpg',
  },
  {
    'album':'Skool Luv Affair',
    'imageAsset':'images/skoolluvaffair.jpg',
  },
  {
    'album':'Skool Luv Affair (Special Addition)',
    'imageAsset':'images/skool-luv-affair-special-addition.jpg',
  },
  {
    'album':'Dark & Wild',
    'imageAsset':'images/darkandwild.jpg',
  },
  {
    'album':'The most beautiful moment in life pt.1',
    'imageAsset':'images/hyyh1.jpg',
  },
  {
    'album':'The most beautiful moment in life pt.2',
    'imageAsset':'images/hyyh2.jpg',
  },
  {
    'album':'The most beautiful moment in life:\nYoung Forever',
    'imageAsset':'images/youngforever.jpg',
  },
  {
    'album':'Wings',
    'imageAsset':'images/wings.jpg',
  },
  {
    'album':'You Never Walk Alone',
    'imageAsset':'images/ynwa.jpg',
  },
  {
    'album':"Love Yourself 承 'HER'",
    'imageAsset':'images/lyher.jpg',
  },
  {
    'album': "Love Yourself 轉 'TEAR'",
    'imageAsset':'images/lytear.jpg',
  },
  {
    'album': "Love Yourself 結 'ANSWER",
    'imageAsset':'images/lyanswer.jpg',
  },
  {
    'album': "Map Of The Soul : PERSONA",
    'imageAsset':'images/motspersona.jpg',
  },
  {
    'album': "Map Of The Soul : 7",
    'imageAsset':'images/mots7.jpg',
  },
  {
    'album': "BE",
    'imageAsset':'images/be.jpg',
  },
  {
    'album': "Butter/Permission to Dance",
    'imageAsset':'images/butter-ptd.jpg',
  },
  {
    'album': "Proof",
    'imageAsset':'images/proof.jpg',
  },
  {
    'album': "PERMISSION TO DANCE ON STAGE - LIVE",
    'imageAsset':'images/bts-ptd-live.jpg',
  },
];

const List<Map<String, dynamic>> jpAlbums = [
  {
    'album':'No More Dream',
    'imageAsset':'images/albums-jp/nomoredream.jpg',
  },
  {
    'album':'Boy In Luv',
    'imageAsset':'images/albums-jp/boyinluv.jpg',
  },
  {
    'album':'Danger',
    'imageAsset':'images/albums-jp/danger.jpg',
  },
  {
    'album':'Wake Up',
    'imageAsset':'images/albums-jp/wakeup.jpg',
  },
  {
    'album':'For You',
    'imageAsset':'images/albums-jp/foryou.jpg',
  },
  {
    'album':'I Need U',
    'imageAsset':'images/albums-jp/ineedu.jpg',
  },
  {
    'album':'Run',
    'imageAsset':'images/albums-jp/run.jpg',
  },
  {
    'album':'Youth',
    'imageAsset':'images/albums-jp/youth.jpg',
  },
  {
    'album':'Blood Sweat & Tears',
    'imageAsset':'images/albums-jp/bst.jpg',
  },
  {
    'album':'MIC DROP/DNA/Crystal Snow',
    'imageAsset':'images/albums-jp/crystalsnow.jpg',
  },
  {
    'album':'Face Yourself',
    'imageAsset':'images/albums-jp/faceyourself.jpg',
  },
  {
    'album':'FAKE LOVE/Airplane pt.2',
    'imageAsset':'images/albums-jp/fl-airplane2.jpg',
  },
  {
    'album':'Lights/Boy With Luv',
    'imageAsset':'images/albums-jp/lights.jpg',
  },
  {
    'album':'Map Of The Soul: 7 ~ The Journey ~',
    'imageAsset':'images/albums-jp/mots7thejourney.jpg',
  },
  {
    'album':'BTS, THE BEST',
    'imageAsset':'images/albums-jp/btsthebest.jpg',
  },
];

const List<Map<String, dynamic>> uoAlbums = [
  {
    'album':'BTS World',
    'imageAsset':'images/bts-world.jpg',
  },
];