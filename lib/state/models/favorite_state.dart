import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../model/word_translation.dart';
import '../../service/word_service.dart';

// ─── Mock data used when backend is unreachable ───────────────────────────────
const List<Map<String, dynamic>> _mockFavorites = [
  {
    'wordId': 1,
    'EnglishWord': 'Machine learning (ml)',
    'KhmerWord': 'សិក្ខាម៉ាស៊ីន',
    'FrenchWord': 'Apprentissage automatique',
    'definition':
        'A type of artificial intelligence that allows computers to learn from data.',
    'example': 'Machine learning is used in recommendation systems.',
    'imageURL': null,
  },
  {
    'wordId': 2,
    'EnglishWord': 'Artificial Intelligence',
    'KhmerWord': 'បញ្ញាសិប្បនិម្មិត',
    'FrenchWord': 'Intelligence artificielle',
    'definition': 'The simulation of human intelligence in machines.',
    'example': 'AI is used in self-driving cars.',
    'imageURL': null,
  },
  {
    'wordId': 3,
    'EnglishWord': 'Database',
    'KhmerWord': 'មូលដ្ឋានទិន្នន័យ',
    'FrenchWord': 'Base de données',
    'definition': 'An organized collection of structured information.',
    'example': 'MySQL is a popular relational database.',
    'imageURL': null,
  },
];

/// State for the favorites feature
class FavoriteState {
  final List<WordTranslation> favorites;
  final bool isLoading;
  final String? error;
  final bool isUsingMockData;

  const FavoriteState({
    this.favorites = const [],
    this.isLoading = false,
    this.error,
    this.isUsingMockData = false,
  });

  FavoriteState copyWith({
    List<WordTranslation>? favorites,
    bool? isLoading,
    String? error,
    bool? isUsingMockData,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isUsingMockData: isUsingMockData ?? this.isUsingMockData,
    );
  }
}

/// Notifier that manages favorites list, toggle, and removal
class FavoriteNotifier extends ChangeNotifier {
  final WordService _wordService;
  FavoriteState _state = const FavoriteState();

  FavoriteNotifier(this._wordService);

  FavoriteState get state => _state;

  /// Fetch all favorite words for the logged-in user.
  /// Falls back to mock data if the backend is unreachable or returns an error.
  Future<void> fetchFavorites(String? token) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    // If no token, use mock data immediately
    if (token == null) {
      _loadMockData();
      return;
    }

    try {
      final response = await _wordService.getAllFavorites(token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final words = data.map((e) => WordTranslation.fromJson(e)).toList();
        _state = _state.copyWith(
          favorites: words,
          isLoading: false,
          isUsingMockData: false,
        );
      } else {
        // Backend error -> fallback to mock
        _loadMockData();
      }
    } catch (_) {
      // Network error -> fallback to mock
      _loadMockData();
    }
    notifyListeners();
  }

  /// Remove a word from favorites (toggle off).
  Future<void> removeFavorite(int wordId, String? token) async {
    if (token == null || _state.isUsingMockData) {
      // Offline: just remove from local list
      final updated = _state.favorites
          .where((w) => w.wordId != wordId)
          .toList();
      _state = _state.copyWith(favorites: updated);
      notifyListeners();
      return;
    }

    try {
      final response = await _wordService.deleteFavorite(
        wordId.toString(),
        token,
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        final updated = _state.favorites
            .where((w) => w.wordId != wordId)
            .toList();
        _state = _state.copyWith(favorites: updated);
        notifyListeners();
      }
    } catch (_) {
      // Silently fail; UI stays
    }
  }

  void _loadMockData() {
    final words = _mockFavorites
        .map((e) => WordTranslation.fromJson(e))
        .toList();
    _state = FavoriteState(
      favorites: words,
      isLoading: false,
      isUsingMockData: true,
    );
    notifyListeners();
  }
}
