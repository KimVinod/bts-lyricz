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