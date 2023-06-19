import 'package:bts_lyrics_app/screens/favorites/favorites_screen.dart';
import 'package:bts_lyrics_app/screens/home/tabs/home_tab.dart';
import 'package:bts_lyrics_app/screens/settings/settings_screen.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme {
  Light,
  Dark,
  Bora,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  AppTheme _currentTheme = AppTheme.Bora;

  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late ScrollController scrollController;

  void _toggleTheme() {
    setState(() {
      if (_currentTheme == AppTheme.Light) {
        _currentTheme = AppTheme.Dark;
      } else if (_currentTheme == AppTheme.Dark) {
        _currentTheme = AppTheme.Bora;
      } else {
        _currentTheme = AppTheme.Light;
      }
    });
  }

  ThemeData _getThemeData() {
    switch (_currentTheme) {
      case AppTheme.Light:
        return ThemeData.light(useMaterial3: true);
      case AppTheme.Dark:
        return ThemeData.dark(useMaterial3: true);
      case AppTheme.Bora:
        return ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
          primaryColor: appUILightColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: appUILightColor),
        );
    }
  }

  int currentPage = 0;
  late TabController tabController;

  @override
  void dispose() {
    _pageController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
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
    tabController.animation?.addListener(
          () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appUILightColor,
      body: BottomBar(
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        width: MediaQuery.of(context).size.width * 0.8,
        barColor: appBarColor,
        showIcon: false,
        bottom: 16,
        body: (context, controller) {
          scrollController = controller;
          return SafeArea(
            child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            dragStartBehavior: DragStartBehavior.start,
            children: [
              HomeTab(controller: controller),
              FavoritesScreen(controller: controller),
              ListView.builder(
                controller: controller,
                itemCount: 20,
                itemBuilder: (context, index) => ListTile(title: const Text("huhu"), onTap: () {}),
              ),
              SettingsScreen(controller: controller),
            ],
        ),
          );
        },
        child: TabBar(
          onTap: (index) {
            if(index == 0) {
              if(scrollController.hasClients) {
                scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
              }
            }
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
    );
  }
}
