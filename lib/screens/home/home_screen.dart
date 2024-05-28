import 'dart:async';
import 'package:bts_lyrics_app/screens/home/main.dart';
import 'package:bts_lyrics_app/screens/home/tabs/favorites_tab.dart';
import 'package:bts_lyrics_app/screens/home/tabs/game_tab.dart';
import 'package:bts_lyrics_app/screens/home/tabs/home_tab.dart';
import 'package:bts_lyrics_app/screens/home/tabs/settings_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  int currentPage = 0;
  int _selectedIndex = 0;
  ScrollController scrollController = ScrollController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> onWillPop() {
    if(_selectedIndex != 0) {
      _onPageChanged(0);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          top: false,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              const HomeTab(),
              const FavoritesTab(),
              GameTab(onQuit: () => _onPageChanged(0)),
              const SettingsTab(),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => _onPageChanged(index),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainer : Theme.of(context).colorScheme.primaryContainer,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
            NavigationDestination(icon: Icon(Icons.videogame_asset), label: "Mini Game"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
