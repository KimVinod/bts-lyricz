import 'dart:math';
import 'package:bts_lyricz/data/song_data.dart';
import 'package:bts_lyricz/data/song_model.dart';
import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/screens/lyrics/lyrics_screen.dart';
import 'package:bts_lyricz/services/game_service.dart';
import 'package:bts_lyricz/services/settings_service.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:bts_lyricz/utils/widgets/custom_button.dart';
import 'package:bts_lyricz/utils/widgets/game_lyrics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTab extends StatefulWidget {
  final VoidCallback onQuit;
  const GameTab({super.key, required this.onQuit});

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
  String _selectedLanguage = "eng";
  int _currentHighScore = 0;
  bool isLang = false, isHighScore = false;

  void loadSongs() {
    songs = GameService.filterSongs(allSongs, _selectedLanguage);
  }

  void startGame(List<Song> songs) {
    setState(() {
      gameState = GameState.playing;
      int randomIndex = _random.nextInt(songs.length);
      Song song = songs[randomIndex];
      currentLyrics = GameService.getRandomLyrics(song.lyrics, 4, _selectedLanguage, 10);
      if(currentLyrics.eng == "error") startGame(songs);
      correctAnswer = song;

      List<Song> filteredSongs = songs.where((song) => song.name != correctAnswer!.name).toList();
      filteredSongs.shuffle();

      int correctAnswerIndex = _random.nextInt(4);
      filteredSongs.insert(correctAnswerIndex, song);

      options = filteredSongs.take(4).toList();
    });
  }

  void restartGame({required bool isReady}) {
    setState(() {
      gameState = isReady ? GameState.ready : GameState.notReady;
      currentLyrics = const Lyrics();
      correctAnswer = null;
      options = [];
      if(isReady) startGame(songs);
    });
  }

  void checkAnswer(int selectedOptionIndex) {
    String selectedOption = options[selectedOptionIndex].name;
    setState(() {
      if (selectedOption == correctAnswer!.name) {
        gameState = GameState.correct;
        _currentHighScore++;
        SettingsService.saveGameScore(_currentHighScore);
      } else {
        gameState = GameState.incorrect;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference().then((value) => loadSongs());
  }

  Future<void> _loadLanguagePreference() async {
     final language = await SettingsService.loadGameLanguage();
     final highScore = await SettingsService.loadGameScore();
    setState(() {
    _selectedLanguage = language;
    _currentHighScore = highScore;
    isLang = true;
    isHighScore = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics:gameState == GameState.notReady ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text("Guess the Song?", style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.bold)),
          actions: [
            if(_currentHighScore != 0)
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: "Reset highscore",
              onPressed: _currentHighScore != 0
                  ? () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      title: const Text("Reset highscore"),
                      content: const Text("Are you sure you want to reset your highscore?"),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text("No", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),)),
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                          SettingsService.clearGameScore();
                          setState(() => _currentHighScore = 0);
                          restartGame(isReady: false);
                        },child: Text("Yes", style: GoogleFonts.openSans(fontWeight: FontWeight.w600),)),
                      ]
                  );
                });
              } : null,
            ),
            IconButton(
              icon: const Icon(Icons.translate),
              tooltip: "Select language",
              onPressed: () => SettingsService.openGameLanguageDialog(context, (result) {
                if (result == true) {
                  _loadLanguagePreference().then((value) {
                    loadSongs();
                    restartGame(isReady: false);
                  });
                }
              }),
            ),
          ],
        ),
      ],
      body: isLang && isHighScore
          ? Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: gameState == GameState.correct || gameState == GameState.incorrect ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if (gameState == GameState.notReady)
              ...[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {}),
                        child: Image.asset(
                          getBt21Pic(),
                          height: MediaQuery.sizeOf(context).height * 0.25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Are you ready to test your BTS knowledge?\nPlay and have fun ♡",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        width: 160,
                        text: "PLAY",
                        onTap: () => _loadLanguagePreference().then((value) => startGame(songs)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Highscore: \n$_currentHighScore",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Language mode: \n${_selectedLanguage == "eng" ? "English" : _selectedLanguage == "kor" ? "Korean": _selectedLanguage == "jp" ? "Japanese" : ""}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              ]
            else
              if (gameState == GameState.playing)
                ...[
                  GameLyricsCard(currentLyrics: currentLyrics, selectedLanguage: _selectedLanguage),
                  const SizedBox(height: 16),
                  Text(
                    "Choose the right option",
                    style: GoogleFonts.openSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
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
                  GameLyricsCard(currentLyrics: currentLyrics, selectedLanguage: _selectedLanguage),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => setState(() {}),
                    child: Center(
                      child: Image.asset(getBt21Pic(), height: MediaQuery.sizeOf(context).height * 0.15),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (gameState == GameState.correct)
                    ...[
                      Center(
                        child: Text(
                          "Woohoo! You got it right!",
                          style: GoogleFonts.openSans(fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Highscore: $_currentHighScore",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 16),
                    ],
                  if (gameState == GameState.incorrect)
                    ...[
                      Center(
                        child: Text(
                          "Ahh! That's not the right one. Keep trying!",
                          style: GoogleFonts.openSans(fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          "Highscore: $_currentHighScore",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(fontSize: 16, fontStyle: FontStyle.italic),
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
                          child: FadeInAnimation(child: CustomButton(
                              text: 'Restart', onTap: () => restartGame(isReady: true))),),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AnimationConfiguration.synchronized(
                          duration: const Duration(milliseconds: 500),
                          child: FadeInAnimation(child: CustomButton(
                              text: 'Quit', onTap: widget.onQuit)),),
                      ),
                    ],
                  ),
                ],
          ],
        ),
      )
          : SizedBox(),
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
                        color: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.tertiaryContainer,
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
                        overlayColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)),
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => index == null ? Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsPage(songLyrics: song.lyrics, songName: song.displayName, songFullName: song.name, songLink: song.songLink, releaseDate: song.releaseDate, songAlbumArt: song.albumArt, songArtistName: getArtistName(song.isSolo.soloName ?? ""),))) : checkAnswer(index),
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