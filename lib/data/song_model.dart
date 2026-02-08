class Song {
  final String name;
  final String displayName;
  final IsSolo isSolo;
  final bool? isArmy;
  final String? album;
  final String albumArt;
  final String lang;
  final Lyrics lyrics;
  final SongLink songLink;
  final String releaseDate;

  const Song({required this.name, required this.displayName, required this.isSolo, this.isArmy, this.album, required this.lang, required this.lyrics, required this.albumArt, required this.songLink, required this.releaseDate});

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

class SongLink {
  final String? spotify, soundcloud, youtube;

  const SongLink({this.spotify, this.soundcloud, this.youtube});
}

class SearchableSong {
  final Song song;
  final String cleanName;
  final String cleanAlbum;
  final String cleanLyrics;

  SearchableSong({
    required this.song,
    required this.cleanName,
    required this.cleanAlbum,
    required this.cleanLyrics,
  });
}