import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_responsi/models/anime.dart';
import 'package:mobile_responsi/models/favorite_anime.dart';

class FavoriteController extends GetxController {
  final Box<FavoriteAnime> _box = Hive.box<FavoriteAnime>('favorites');

  final RxList<FavoriteAnime> _favorites = <FavoriteAnime>[].obs;
  List<FavoriteAnime> get favorites => _favorites;

  @override
  void onInit() {
    _loadFavorites();
    super.onInit();
  }

  void _loadFavorites() {
    _favorites.assignAll(_box.values.toList());
  }

  bool isFavorite(int id) {
    return _favorites.any((fav) => fav.id == id);
  }

  Future<bool> toggleFavorite(Anime anime) async {
    if (isFavorite(anime.id)) {
      await _box.delete(anime.id);
      _loadFavorites();
      return false;
    } else {
      await _box.put(anime.id, FavoriteAnime.fromAnime(anime));
      _loadFavorites();
      return true;
    }
  }

  Future<void> removeFavorite(int id) async {
    await _box.delete(id);
    _loadFavorites();
  }
}