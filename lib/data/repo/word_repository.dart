import 'dart:convert';
import 'package:domra_tech/model/word_translation.dart';
import '../../service/word_service.dart';

class WordRepository {
  final WordService _wordService;

  WordRepository(this._wordService);

  // Search logic
  Future<List<WordTranslation>> searchWords(String query) async {
    final data = await _wordService.searchWords(query);

    return data.map<WordTranslation>((json) => WordTranslation.fromJson(json)).toList();
  }

  //Get all word
  Future<List<WordTranslation>> getAllWords() async {
    final response = await _wordService.getAllWords();

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];

      return data.map((word) => WordTranslation.fromJson(word)).toList();
    }

    return [];
  }

  // Get word by Id
  Future<WordTranslation?> getWordById(int wordId) async {
    final response = await _wordService.getWordById(wordId.toString());
    
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final wordData = jsonBody['data'] ?? jsonBody; // Adjust according to actual backend response
      return WordTranslation.fromJson(wordData);
    }
    return null;
  }

  // Get the recent added words
  Future<List<WordTranslation>> getRecentWords() async {
    final response = await _wordService.getAllWords(limit: 10);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      final List wordsJson = jsonBody["words"] ?? [];

      return wordsJson.map((json) => WordTranslation.fromJson(json)).toList();
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
