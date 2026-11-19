import 'package:get/get.dart';
import 'package:mobile_responsi/services/auth_service.dart';

class AuthController extends GetxController {
  final _authService = AuthService();

  final RxString _username = ''.obs;
  String get username => _username.value;

  @override
  void onInit() {
    _loadUsername();
    super.onInit();
  }

  Future<void> _loadUsername() async {
    _username.value = await _authService.getUsername();
  }

  Future<bool> login(String username, String password) async {
    final success = await _authService.login(username, password);
    if (success) {
      _username.value = username;
    }
    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    _username.value = '';
    Get.offAllNamed('/login'); 
  }
}