import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  final ScrollController controller;
  const GameScreen({super.key, required this.controller});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
                    "Guess the Song?",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            controller: widget.controller,
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ],
    );
  }
}
