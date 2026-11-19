import 'package:get/get.dart';
import 'package:mobile_responsi/models/anime.dart';
import 'package:mobile_responsi/services/anime_api_service.dart';

class AnimeController extends GetxController {
  final _service = AnimeApiService();

  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxList<Anime> _animes = <Anime>[].obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  List<Anime> get animes => _animes;

  @override
  void onInit() {
    fetchAnimes();
    super.onInit();
  }

  Future<void> fetchAnimes() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      final data = await _service.fetchAnimes();
      _animes.assignAll(data);
    } catch (e) {
      _errorMessage.value = 'Gagal memuat data. Cek koneksi internet kamu.';
    } finally {
      _isLoading.value = false;
    }
  }
}