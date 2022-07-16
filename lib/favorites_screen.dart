import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  late Box userFavLyricsBox;
  List userFavLyrics = [];
  bool isFav = false;

  loadData() async {
    userFavLyricsBox = await Hive.openBox('userFavourites');
    //userFavLyricsBox.clear();
    setState(() {
      userFavLyrics = userFavLyricsBox.get('favouritesList',defaultValue: []);
    });
    print("load favList: $userFavLyrics");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text("Favorites"),
          backgroundColor: Color.fromRGBO(150, 86, 190, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Color.fromRGBO(180, 136, 212, 1),
        body: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification> (
            onNotification: (OverscrollIndicatorNotification overScroll){
              overScroll.disallowIndicator();
              return true;
            },
            child: userFavLyrics.isNotEmpty
                ? Column(
                  children: [
                    SizedBox(height: 15),
                    Text("Swipe to remove songs  >.<",style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontStyle: FontStyle.italic
                    ),),
                    Expanded(
                      child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: userFavLyrics.length,
              itemBuilder: (context, index) {
                      final item = userFavLyrics[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Dismissible(
                          key: Key(item),
                          onDismissed: (DismissDirection direction) {
                            userFavLyrics.remove(item);
                            userFavLyricsBox.put("favouritesList", userFavLyrics);
                            setState(() {});
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 3,
                            color: Colors.transparent,
                            shadowColor: Colors.purple.shade700,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(152, 105, 190, 1),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            userFavLyrics[index],
                                            style: GoogleFonts.openSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
                    ),
                  ],
                )
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Nothing here  ~.~", style: GoogleFonts.openSans(fontSize: 18, fontStyle: FontStyle.italic),),
                      SizedBox(height: 20),
                      Text("Add your favorite songs by clicking on the heart icon in lyrics screen", textAlign: TextAlign.center, style: GoogleFonts.openSans(fontSize: 18, fontStyle: FontStyle.italic),),
                    ],

            ),
                )

          )
        ),
      ),
    );
  }
}
