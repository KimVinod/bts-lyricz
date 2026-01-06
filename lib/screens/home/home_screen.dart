import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/screens/home/tabs/favorites_tab.dart';
import 'package:bts_lyricz/screens/home/tabs/game_tab.dart';
import 'package:bts_lyricz/screens/home/tabs/home_tab.dart';
import 'package:bts_lyricz/screens/home/tabs/settings_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  int currentPage = 0;
  int _selectedIndex = 0;
  final ScrollController scrollController = ScrollController();
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

  void onPop(bool didPop, dynamic result) {
    if(_selectedIndex != 0) {
      _onPageChanged(0);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: onPop,
      canPop: _selectedIndex == 0,
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
