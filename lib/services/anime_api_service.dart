import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_responsi/models/anime.dart';

class AnimeApiService {
  final String _baseUrl = "https://kitsu.io/api/edge/anime";

  Future<List<Anime>> fetchAnimes() async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'page[limit]': '20',
      'page[offset]': '0',
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((item) => Anime.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data anime');
    }
  }

  Future<Anime> fetchAnimeDetail(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['data'];
      return Anime.fromJson(data);
    } else {
      throw Exception('Gagal mengambil detail anime');
    }
  }
}