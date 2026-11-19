import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_responsi/models/anime.dart';
part 'favorite_anime.g.dart';

@HiveType(typeId: 0)
class FavoriteAnime extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String titles;

  @HiveField(2)
  final String? posterImage;

  @HiveField(3)
  final String? ageRating;

  @HiveField(4)
  final double? averageRating;

  FavoriteAnime({
    required this.id,
    required this.titles,
    this.posterImage,
    this.ageRating,
    this.averageRating,
  });

  factory FavoriteAnime.fromAnime(Anime anime) {
    return FavoriteAnime(
      id: anime.id,
      titles: anime.titles,
      posterImage: anime.posterImage,
      ageRating: anime.ageRating,
      averageRating: anime.averageRating,
    );
  }
}