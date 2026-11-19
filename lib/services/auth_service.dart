import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _validUsername = '124240013';
  static const String _validPassword = '123';

  Future<bool> login(String username, String password) async {
    if (username == _validUsername && password == _validPassword) {
      final pref = await SharedPreferences.getInstance();
      await pref.setBool('isLoggedIn', true);
      await pref.setString('username', username);
      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isLoggedIn') ?? false;
  }

  Future<String> getUsername() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('username') ?? '';
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}