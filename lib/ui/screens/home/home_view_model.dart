import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/data/repo/word_repository.dart';
import 'package:domra_tech/service/speech_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final WordRepository _wordRepository;

  HomeViewModel(this._wordRepository);

  List<WordTranslation> _words = [];
  bool _isLoading = false;
  bool _isOfflineData = false;
  String? _error;

  List<WordTranslation> get words => _words;
  bool get isLoading => _isLoading;
  bool get isOfflineData => _isOfflineData;
  String? get error => _error;

  //voice search
  final SpeechService _speechService = SpeechService();
  // final LanguageService _languageService = LanguageService(); //use later

  bool _isListening = false;
  //String _detectedLanguage = "english";

  bool get isListening => _isListening;
  //String get detectedLanguage => _detectedLanguage;

  //initial speech
  Future<void> initSpeech() async {
    await _speechService.init();
  }

  //start voice search
  Future<void> startVoiceSearch(Function(String) onTextUpdate) async {
    if (_isListening) return; // prevent duplicate start
    _isListening = true;
    notifyListeners();

    await _speechService.listen(
      onResult: (text) async {
        onTextUpdate(text); // update TextField UI

        // detect language
        //_detectedLanguage = await _languageService.detect(text);

        //call existing search function
        await searchWords(text);
        _speechService.stop();

        _isListening = false;
        notifyListeners();
      },
    );
  }

  //stop vioce search
  void stopVoiceSearch() {
    if (!_isListening) return;

    _speechService.stop();
    _isListening = false;
    notifyListeners();
  }

  //Fetch all words
  Future<void> fetchAllwords() async {
    _isLoading = true;
    _error = null;
    _isOfflineData = false;

    notifyListeners();
    try {
      final result = await _wordRepository.getAllWords();
      debugPrint('API returned: $result');
      _words = result;
      _isOfflineData = _wordRepository.isLastFetchFromCache;
    } catch (e) {
      debugPrint('Failed to fetch words: $e');
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  //Fetch recent words
  Future<void> fetchRecentWords() async {
    _isLoading = true;
    _isOfflineData = false;
    notifyListeners();

    try {
      debugPrint("Fetching words from repository...");

      final result = await _wordRepository.getRecentWords();

      debugPrint("Repository returned: ${result.length}");

      _words = result;
      _isOfflineData = _wordRepository.isLastFetchFromCache;
    } catch (e) {
      debugPrint("Error fetching words: $e");
      _words = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Search limit properties
  bool _hasReachedSearchLimit = false;
  bool get hasReachedSearchLimit => _hasReachedSearchLimit;

  //Search query
  Future<void> searchWords(String query) async {
    if (query.isEmpty) {
      _hasReachedSearchLimit = false;
      await fetchRecentWords();
      return;
    }

    _isLoading = true;
    _isOfflineData = false;
    _hasReachedSearchLimit = false;
    notifyListeners();

    try {
      _words = await _wordRepository.searchWords(query);
      _isOfflineData = _wordRepository.isLastFetchFromCache;
    } catch (e) {
      if (e.toString().contains('RATE_LIMIT_EXCEEDED')) {
        _hasReachedSearchLimit = true;
        _words = [];
      } else {
        _error = e.toString();
        _words = [];
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() async {
    _words = await _wordRepository.getRecentWords();
    notifyListeners();
  }

  int? _currentCategoryId;

  int? get currentCategoryId => _currentCategoryId;

  Future<void> filterByCategory(int categoryId) async {
    _currentCategoryId = categoryId;

    _isLoading = true;
    notifyListeners();

    try {
      if (categoryId == 0) {
        _words = await _wordRepository.getRecentWords();
      } else {
        print(currentCategoryId);
        _words = await _wordRepository.getWordsByCategory(categoryId);
        print(_words);
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
