
class Song {
  final String name;
  final String displayName;
  final IsSolo isSolo;
  final String? album;
  final String albumArt;
  final String lang;
  final Lyrics lyrics;

  const Song({required this.name, required this.displayName, required this.isSolo, this.album, required this.lang, required this.lyrics, required this.albumArt});

}


class Lyrics {
  final String? eng;
  final String? rom;
  final String? kr;
  final String? jp;

  const Lyrics({this.eng, this.rom, this.kr, this.jp});
}

class IsSolo {
  final bool isSolo;
  final String? soloName;
  final bool? isUnofficial;

  const IsSolo({required this.isSolo, this.soloName, this.isUnofficial});
}