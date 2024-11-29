import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String _apiKey = 'd02f5e56707946b693c5184522d84c33';
  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchTopHeadlines() async {
    final response = await http.get(Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
