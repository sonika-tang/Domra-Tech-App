import 'dart:convert';
import 'package:domra_tech/model/word_translation.dart';
import '../../service/word_service.dart';
import '../../service/connectivity_service.dart';
import '../local/database_helper.dart';

class WordRepository {
  final WordService _wordService;
  final ConnectivityService _connectivityService = ConnectivityService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Flag to indicate if last fetched data was from cache
  bool _isLastFetchFromCache = false;
  bool get isLastFetchFromCache => _isLastFetchFromCache;

  WordRepository(this._wordService);

  // Search logic
  Future<List<WordTranslation>> searchWords(String query) async {
    // For specific searches, we might not want to rely on the general cache,
    // but if we are offline, we could try to search within the cached words locally as an enhancement.
    // For now, attempting the API fetch.
    bool isConnected = await _connectivityService.isConnected;
    
    if (!isConnected) {
      _isLastFetchFromCache = true;
      final cached = await _databaseHelper.getCachedWords();
      // Basic local filtering
      return cached.where((word) => 
        (word.englishWord?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
        (word.khmerWord.contains(query))
      ).toList();
    }

    _isLastFetchFromCache = false;
    final data = await _wordService.searchWords(query);
    return data.map<WordTranslation>((json) => WordTranslation.fromJson(json)).toList();
  }

  //Get all word
  Future<List<WordTranslation>> getAllWords() async {
    bool isConnected = await _connectivityService.isConnected;

    if (!isConnected) {
      _isLastFetchFromCache = true;
      return await _databaseHelper.getCachedWords();
    }

    _isLastFetchFromCache = false;
    final response = await _wordService.getAllWords();

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      final words = data.map((word) => WordTranslation.fromJson(word)).toList();
      await _databaseHelper.cacheWords(words); // Cache the full list
      return words;
    }

    return [];
  }

  // Get word by Id
  Future<List<WordTranslation>> getWordsByCategory(int categoryId) async {
    final response = await _wordService.getWordsByCategory(categoryId.toString());

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List wordsJson = jsonBody["words"] ?? [];
      return wordsJson.map((json) => WordTranslation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load words by category');
    }
  }

  // Get the recent added words
  Future<List<WordTranslation>> getRecentWords() async {
    bool isConnected = await _connectivityService.isConnected;

    if (!isConnected) {
      // Offline: use cache!
      _isLastFetchFromCache = true;
      return await _databaseHelper.getCachedWords();
    }

    _isLastFetchFromCache = false;
    final response = await _wordService.getAllWords(limit: 10);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List wordsJson = jsonBody["words"] ?? [];
      final words = wordsJson.map((json) => WordTranslation.fromJson(json)).toList();
      
      // Update cache with the recent words
      await _databaseHelper.cacheWords(words);
      return words;
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
