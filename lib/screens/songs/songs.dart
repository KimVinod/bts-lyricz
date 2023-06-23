import 'package:bts_lyrics_app/data/song_data.dart';
import 'package:bts_lyrics_app/data/song_model.dart';
import 'package:bts_lyrics_app/screens/lyrics/lyrics_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bts_lyrics_app/utils/ui_constants.dart';

class Songs extends StatefulWidget {
  final String albumName;
  final String albumArt;

  const Songs({Key? key, required this.albumName, required this.albumArt}) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  List<Song> songs = [];

  void loadSongs() {
    setState(() {
      songs = allSongs.where((s) => s.album == widget.albumName).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Songs", style: GoogleFonts.openSans(fontWeight: FontWeight.w500),),
        titleSpacing: 0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Material(
                        elevation: 3,
                        shadowColor: Theme.of(context).colorScheme.shadow,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 150,
                          height: 170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(image: AssetImage(widget.albumArt), fit: BoxFit.fill)
                          ),
                        )),
                    const SizedBox(height: 6),
                    Text(
                      widget.albumName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Songs",
                style: GoogleFonts.openSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Card(
                  elevation: 3,
                  shadowColor: Theme.of(context).colorScheme.shadow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Theme.of(context).colorScheme.tertiary,
                  child: RawScrollbar(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    thumbColor: Theme.of(context).cardColor,
                    thickness: 5.0,
                    radius: const Radius.circular(15.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black38 : Colors.white30, height: 1, thickness: 0.6),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            songs[index].name,
                            style: GoogleFonts.openSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsPage(
                            songFullName: songs[index].name,
                            songName: songs[index].displayName,
                            songLyrics: songs[index].lyrics,
                          ))),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
