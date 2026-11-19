import 'package:get/get.dart';
import 'package:mobile_responsi/models/anime.dart';
import 'package:mobile_responsi/services/anime_api_service.dart';

class DetailController extends GetxController {
  final _service = AnimeApiService();

  final int animeId = Get.arguments as int;

  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rxn<Anime> _anime = Rxn<Anime>();

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  Anime? get anime => _anime.value;

  @override
  void onInit() {
    fetchDetail();
    super.onInit();
  }

  Future<void> fetchDetail() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      _anime.value = await _service.fetchAnimeDetail(animeId);
    } catch (e) {
      _errorMessage.value = 'Gagal memuat detail. Cek koneksi internet kamu.';
    } finally {
      _isLoading.value = false;
    }
  }
}