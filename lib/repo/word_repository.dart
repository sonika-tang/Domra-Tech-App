import 'dart:convert';
import '../service/word_service.dart';

class WordRepository {
  final WordService _wordService;

  WordRepository(this._wordService);

  // Search logic
  Future<List<dynamic>> searchWords(String query) async {
    final response = await _wordService.searchWords(query);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']; // Mapping the JSON data
    }
    return [];
  }

  // Favorite logic (requires token from AuthRepository)
  Future<bool> addToFavorite(String wordId, String token) async {
    final response = await _wordService.createFavorite(wordId, token);
    return response.statusCode == 201;
  }

  Future<bool> removeFromFavorite(String wordId, String token) async {
    final response = await _wordService.deleteFavorite(wordId, token);
    return response.statusCode == 200;
  }
}
