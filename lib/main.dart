import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_responsi/controllers/auth_controller.dart';
import 'package:mobile_responsi/models/favorite_anime.dart';
import 'package:mobile_responsi/services/auth_service.dart';
import 'package:mobile_responsi/views/bindings/detail_binding.dart';
import 'package:mobile_responsi/views/bindings/main_binding.dart';
import 'package:mobile_responsi/views/pages/detail_pages.dart';
import 'package:mobile_responsi/views/pages/login_pages.dart';
import 'package:mobile_responsi/views/pages/main_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Bootstrap());
}

class Bootstrap extends StatefulWidget {
  const Bootstrap({super.key});

  @override
  State<Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends State<Bootstrap> {
  String _status = '1/3 Menyiapkan Hive...';
  String? _error;
  bool? _isLoggedIn; 

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await Hive.initFlutter().timeout(const Duration(seconds: 10));
      if (!mounted) return;
      setState(() => _status = '2/3 Membuka database favorit...');

      Hive.registerAdapter(FavoriteAnimeAdapter());
      await Hive.openBox<FavoriteAnime>('favorites')
          .timeout(const Duration(seconds: 10));
      if (!mounted) return;
      setState(() => _status = '3/3 Mengecek login...');

      Get.put(AuthController(), permanent: true);
      final logged =
          await AuthService().isLoggedIn().timeout(const Duration(seconds: 10));
      if (!mounted) return;
      setState(() => _isLoggedIn = logged);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn != null) {
      return MainApp(isLoggedIn: _isLoggedIn!);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _error != null ? 'ERROR:\n$_error' : _status,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Keripikroll',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7A68FB),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Color(0xFF7A68FB),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: isLoggedIn ? '/main' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(
          name: '/main',
          page: () => const MainPage(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/detail',
          page: () => const DetailPage(),
          binding: DetailBinding(),
        ),
      ],
    );
  }
}