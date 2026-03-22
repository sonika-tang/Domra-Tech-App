import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/repo/word_repository.dart';
import 'package:domra_tech/service/language_service.dart';
import 'package:domra_tech/service/speech_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final WordRepository _wordRepository;

  HomeViewModel(this._wordRepository);

  List<WordTranslation> _words = [];
  bool _isLoading = false;
  String? _error;

  List<WordTranslation> get words => _words;
  bool get isLoading => _isLoading;
  String? get error => _error;

  //voice search
  final SpeechService _speechService = SpeechService();
  final LanguageService _languageService = LanguageService(); //use later

  bool _isListening = false;
  String _detectedLanguage = "english";

  bool get isListening => _isListening;
  String get detectedLanguage => _detectedLanguage;

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

    notifyListeners();
    try {
      final result = await _wordRepository.getAllWords();
      debugPrint('API returned: $result');
      _words = result;
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
    notifyListeners();

    try {
      debugPrint("Fetching words from repository...");

      final result = await _wordRepository.getRecentWords();

      debugPrint("Repository returned: ${result.length}");

      _words = result;
    } catch (e) {
      debugPrint("Error fetching words: $e");
      _words = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  //Search query
  Future<void> searchWords(String query) async {
    if (query.isEmpty) {
      _words = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _words = await _wordRepository.searchWords(query);

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() async {
    _words = await _wordRepository.getRecentWords();
    notifyListeners();
  }
}
