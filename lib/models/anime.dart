class Anime {
  final int id;
  final String titles;
  final String? posterImage;
  final String? coverImage;
  final String? ageRating;
  final double? averageRating;
  final int? episodeCount;
  final String? synopsis;

  Anime({
    required this.id,
    required this.titles,
    this.posterImage,
    this.coverImage,
    this.ageRating,
    this.averageRating,
    this.episodeCount,
    this.synopsis,
  });

  static String? _secure(String? url) => url?.replaceFirst('http://', 'https://');

  String get cleanSynopsis {
    if (synopsis == null || synopsis!.trim().isEmpty) {
      return 'Tidak ada sinopsis.';
    }
    return synopsis!.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  factory Anime.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'] as Map<String, dynamic>;
    return Anime(
      id: int.parse(json['id'].toString()),
      titles: (attr['titles']?['en_jp'] ?? attr['canonicalTitle'] ?? '-').toString(),
      posterImage: _secure(attr['posterImage']?['small']),
      coverImage: _secure(attr['coverImage']?['small']), 
      ageRating: attr['ageRating'],
      averageRating: double.tryParse(attr['averageRating']?.toString() ?? ''),
      episodeCount: attr['episodeCount'], 
      synopsis: attr['synopsis'],
    );
  }
}