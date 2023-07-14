import 'dart:math';
import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_screen.dart';
import 'package:bts_lyrics_app/services/game_service.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:bts_lyrics_app/utils/widgets/custom_button.dart';
import 'package:bts_lyrics_app/utils/widgets/game_lyrics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTab extends StatefulWidget {
  final ScrollController controller;
  final VoidCallback onQuit;
  const GameTab({super.key, required this.controller, required this.onQuit});

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {

  GameState gameState = GameState.notReady;
  Lyrics currentLyrics = const Lyrics();
  Song? correctAnswer;
  final _random = Random();
  List<Song> options = [];
  List<Song> songs = [];

  void loadSongs() {
    songs = GameService.filterSongs(allSongs);
  }

  void startGame(List<Song> songs) {
    gameState = GameState.playing;
    int randomIndex = _random.nextInt(songs.length);
    Song song = songs[randomIndex];
    currentLyrics = GameService.getRandomLyrics(song.lyrics, 4);
    correctAnswer = song;

    List<Song> filteredSongs = songs.where((song) => song.name != correctAnswer!.name).toList();
    filteredSongs.shuffle();

    int correctAnswerIndex = _random.nextInt(4);
    filteredSongs.insert(correctAnswerIndex, song);

    options = filteredSongs.take(4).toList();

    setState(() {});
  }

  void restartGame() {
    gameState = GameState.ready;
    currentLyrics = const Lyrics();
    correctAnswer = null;
    options = [];

    setState(() {});
  }

  void checkAnswer(int selectedOptionIndex) {
    String selectedOption = options[selectedOptionIndex].name;
    if (selectedOption == correctAnswer!.name) {
      gameState = GameState.correct;
    } else {
      gameState = GameState.incorrect;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  @override
  Widget build(BuildContext context) {

    if(gameState == GameState.ready) {
      startGame(songs);
    }

    return Column(
      children: [
        Container(
          height: 56,
          color: Theme.of(context).colorScheme.secondary,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Theme.of(context).colorScheme.secondary,
            elevation: 4,
            child: Stack(
              children: [
                Align(
                  child: Text(
                    "Guess the Song?",
                    style: GoogleFonts.openSans(
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (gameState == GameState.notReady)
                  ...[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(onTap: () => setState(() {}), child: Image.asset(getBt21Pic(), height: MediaQuery.of(context).size.height * 0.25)),
                          const SizedBox(height: 8),
                          Text(
                            "Are you ready to test your BTS knowledge?\nPlay and have fun ♡",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 16),
                          CustomButton(width: 160, text: "PLAY", onTap: () => startGame(songs)),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ]
                else if (gameState == GameState.playing)
                  ...[
                    GameLyricsCard(currentLyrics: currentLyrics),
                    const SizedBox(height: 16),
                    Text(
                      "Choose the right option",
                      style: GoogleFonts.openSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: AnimationLimiter(
                        child: ListView(
                          controller: widget.controller,
                          physics: const BouncingScrollPhysics(),
                          children: options.asMap().entries.map((entry) {
                            int index = entry.key;
                            Song song = entry.value;
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: buildOptions(song, index),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ]
                else
                  ...[
                    GameLyricsCard(currentLyrics: currentLyrics),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => setState(() {}),
                      child: Center(child: Image.asset(getBt21Pic(), height: MediaQuery.of(context).size.height * 0.15)),
                    ),
                    const SizedBox(height: 8),
                    if (gameState == GameState.correct)
                      ...[
                        Center(
                          child: Text(
                            "Woohoo! You got it right!",
                            style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    if (gameState == GameState.incorrect)
                      ...[
                        Center(
                          child: Text(
                            "Ahh! That's not the right one. Keep trying!",
                            style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    buildOptions(correctAnswer!, null),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: AnimationConfiguration.synchronized(
                            duration: const Duration(milliseconds: 500),
                            child: FadeInAnimation(child: CustomButton(text: 'Restart', onTap: restartGame)),),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AnimationConfiguration.synchronized(
                            duration: const Duration(milliseconds: 500),
                            child: FadeInAnimation(child: CustomButton(text: 'Quit', onTap: widget.onQuit)),),
                        ),
                      ],
                    ),
                  ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOptions(Song song, int? index) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 500),
      child: FadeInAnimation(
        child: Bounceable(
          onTap: () {},
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 3,
            color: Colors.transparent,
            shadowColor: Theme.of(context).colorScheme.shadow,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 85,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 85,
                          height: 85,
                          child: Image.asset(song.albumArt),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            song.name,
                            style: GoogleFonts.openSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => index == null ? Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsPage(songLyrics: song.lyrics, songName: song.displayName, songFullName: song.name))) : checkAnswer(index),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

}

