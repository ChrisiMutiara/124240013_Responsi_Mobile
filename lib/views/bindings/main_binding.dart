import 'package:get/get.dart';
import 'package:mobile_responsi/controllers/anime_controller.dart';
import 'package:mobile_responsi/controllers/favorite_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnimeController());
    Get.lazyPut(() => FavoriteController());
  }
}