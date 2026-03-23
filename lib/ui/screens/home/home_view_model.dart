import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/data/repo/word_repository.dart';
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
