import 'dart:async';
import 'package:bts_lyrics_app/screens/home/tabs/favorites_tab.dart';
import 'package:bts_lyrics_app/screens/home/tabs/game_tab.dart';
import 'package:bts_lyrics_app/screens/home/tabs/home_tab.dart';
import 'package:bts_lyrics_app/screens/home/tabs/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  int currentPage = 0;
  int _selectedIndex = 0;
  Timer timer = Timer(const Duration(seconds: 0), () {});
  late TabController tabController;
  late AnimationController animationController;
  ScrollController scrollController = ScrollController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
      tabController.animateTo(index);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      /*_pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );*/
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  void showBottomBar(ScrollController scrollController, AnimationController animationController, int timerSecs) {
    if (scrollController.hasClients) {
      if(timer.isActive) timer.cancel();
      timer = Timer(Duration(seconds: timerSecs), () => (animationController.status == AnimationStatus.dismissed) ? animationController.forward() : {});
    }
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: BottomBar(
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: Theme.of(context).cardColor,
          showIcon: false,
          bottom: 16,
          onBottomBarHidden: () {
            showBottomBar(scrollController, animationController, 5);
          },
          body: (context, scrollController, animationController) {

            this.scrollController = scrollController;
            this.animationController = animationController;

            return SafeArea(
              child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                HomeTab(controller: scrollController),
                FavoritesTab(controller: scrollController),
                GameTab(controller: scrollController, onQuit: () => _onPageChanged(0)),
                SettingsTab(controller: scrollController),
              ],
          ),
            );
          },
          child: TabBar(
            onTap: (index) {
              /*if(index == 0) {
                if(scrollController.hasClients) {
                  scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                }
              }*/
              _onItemTapped(index);
            },
            unselectedLabelColor: Colors.white54,
            splashBorderRadius: BorderRadius.circular(500),
            indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            controller: tabController,
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2.5,
                ),
                insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
            tabs: const <Widget>[
              Tooltip(message: "Home", child: Tab(icon: Icon(Icons.home))),
              Tooltip(message: "Favorites", child: Tab(icon: Icon(Icons.favorite))),
              Tooltip(message: "Mini Game", child: Tab(icon: Icon(Icons.videogame_asset_rounded))),
              Tooltip(message: "Settings", child: Tab(icon: Icon(Icons.settings))),
            ],
          ),
        ),
      ),
    );
  }
}
