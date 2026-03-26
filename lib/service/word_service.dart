import 'package:http/http.dart' as http;
import '../core/config/constants.dart';
import 'dart:convert';

class WordService {
  final http.Client client;
  WordService(this.client);

  //Search word by query
  Future<List<dynamic>> searchWords(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/words/search?q=$query'));

    return jsonDecode(response.body);
  }
  //Get all words
  Future<http.Response> getAllWords({int page = 1, int limit = 10, String categoryId = "all"}) async {
    final queryParams = {'page': page.toString(), 'limit': limit.toString(), if (categoryId != 'all') 'categoryId': categoryId};

    final uri = Uri.parse('$baseUrl/words').replace(queryParameters: queryParams);
    return await client.get(uri);
  }

  //Get recent words
  Future<http.Response> getRecentWords() async {
    return await client.get(Uri.parse('$baseUrl/words?limit=10'));
  }

  Future<http.Response> getWordById(String wordId) async {
    return await client.get(Uri.parse('$baseUrl/words/$wordId'));
  }

  Future<http.Response> getWordCard(String wordId) async {
    return await client.get(Uri.parse('$baseUrl/wordcards/$wordId'));
  }

  // Future<http.Response> getSharePage(String wordId) async {
  //   return await client.get(Uri.parse('$baseUrl/share/$wordId'));
  // }

  // Future<http.Response> getShareData(String wordId) async {
  //   return await client.get(Uri.parse('$baseUrl/words/$wordId/share'));
  // }

  Future<http.Response> getAllFavorites(String token) async {
    return await client.get(Uri.parse('$baseUrl/favorites'), headers: {'Authorization': 'Bearer $token'});
  }

  Future<http.Response> createFavorite(String wordId, String token) async {
    return await client.post(
      Uri.parse('$baseUrl/favorites'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode({'wordId': wordId}),
    );
  }

  // NEW: Delete Favorite (router.delete('/favorites/:wordId'))
  Future<http.Response> deleteFavorite(String wordId, String token) async {
    return await client.delete(
      Uri.parse('$baseUrl/favorites/$wordId'), // wordId is part of the URL path
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
  }
}
