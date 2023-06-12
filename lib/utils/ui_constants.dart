import 'package:bts_lyrics_app/screens/discography/albums_jp.dart';
import 'package:bts_lyrics_app/screens/discography/albums_kr.dart';
import 'package:bts_lyrics_app/screens/discography/albums_uo.dart';
import 'package:bts_lyrics_app/screens/discography/digital_singles.dart';
import 'package:bts_lyrics_app/screens/discography/songs_uo.dart';
import 'package:bts_lyrics_app/screens/members/hoseok.dart';
import 'package:bts_lyrics_app/screens/members/jimin.dart';
import 'package:bts_lyrics_app/screens/members/jin.dart';
import 'package:bts_lyrics_app/screens/members/jungkook.dart';
import 'package:bts_lyrics_app/screens/members/namjoon.dart';
import 'package:bts_lyrics_app/screens/members/taehyung.dart';
import 'package:bts_lyrics_app/screens/members/yoongi.dart';
import 'package:flutter/material.dart';

const Color appUILightColor = Color.fromRGBO(180, 136, 212, 1);
const Color appUIDarkColor = Color.fromRGBO(91, 50, 120, 1);
const Color appBarColor = Color.fromRGBO(150, 86, 190, 1);

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
  'images/digital-singles.jpg': DigitalSingles(),
  'images/kr-albums.jpg': AlbumsKR(),
  'images/jp-albums.jpg': AlbumsJP(),
  'images/uo-albums.jpg': AlbumsUO(),
  'images/uo-songs2.jpg': SongsUO(),
};

const List<Map<String, dynamic>> soloProjects = [
  {
    'imageAsset': 'images/members/joon.jpg',
    'name': 'RM',
    'widget': Namjoon(),
  },
  {
    'imageAsset': 'images/members/jin.jpg',
    'name': 'Jin',
    'widget': Jin(),
  },
  {
    'imageAsset': 'images/members/yoongi.jpg',
    'name': 'SUGA / Agust D',
    'widget': Yoongi(),
  },
  {
    'imageAsset': 'images/members/hobi.jpg',
    'name': 'j-hope',
    'widget': Hoseok(),
  },
  {
    'imageAsset': 'images/members/jimin.jpg',
    'name': 'Jimin',
    'widget': Jimin(),
  },
  {
    'imageAsset': 'images/members/tae.jpg',
    'name': 'V',
    'widget': Taehyung(),
  },
  {
    'imageAsset': 'images/members/jk.jpg',
    'name': 'Jungkook',
    'widget': Jungkook(),
  },

];