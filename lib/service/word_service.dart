import 'package:http/http.dart' as http;
import '../core/config/constants.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WordService {
  final http.Client client;
  final _storage = const FlutterSecureStorage();

  WordService(this.client);

  Future<List<dynamic>> searchWords(String query) async {
    final jwt = await _storage.read(key: "jwt");
    final headers = <String, String>{};
    if (jwt != null) {
      headers['Authorization'] = 'Bearer $jwt';
    }

    final response = await client.get(
      Uri.parse('$baseUrl/words/search?q=$query'),
      headers: headers,
    );

    if (response.statusCode == 429 || response.statusCode == 403) {
      throw Exception('RATE_LIMIT_EXCEEDED');
    }

    final decoded = jsonDecode(response.body);
    
    // If the backend returns a Map (like {"data": [...] } or {"words": [...] })
    if (decoded is Map) {
      if (decoded.containsKey('words')) return decoded['words'] as List<dynamic>;
      if (decoded.containsKey('data')) return decoded['data'] as List<dynamic>;
      // if error struct
      if (response.statusCode != 200) {
        if (decoded['message']?.toString().toLowerCase().contains('limit') == true) {
           throw Exception('RATE_LIMIT_EXCEEDED');
        }
        throw Exception(decoded['message'] ?? 'Search failed');
      }
      return []; // Return empty if format unknown
    }

    // If it's directly a list 
    if (decoded is List) {
      return decoded;
    }

    return [];
  }
  //Get all words
  Future<http.Response> getAllWords({int page = 1, String categoryId = "all"}) async {
    final queryParams = {'page': page.toString(), if (categoryId != 'all') 'categoryId': categoryId};

    final uri = Uri.parse('$baseUrl/words').replace(queryParameters: queryParams);
    return await client.get(uri);
  }

  //Get recent words
  Future<http.Response> getRecentWords() async {
    return await client.get(Uri.parse('$baseUrl/words'));
  }

  ///Get words by categorie
 Future<http.Response> getWordsByCategory(String categoryId) async {
    final uri = Uri.parse('$baseUrl/words').replace(queryParameters: {'categoryId': categoryId});

    return await client.get(uri);
  }

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
