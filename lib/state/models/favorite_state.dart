import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../model/word_translation.dart';
import '../../service/word_service.dart';

/// State for the favorites feature
class FavoriteState {
  final List<WordTranslation> favorites;
  final bool isLoading;
  final String? error;

  const FavoriteState({this.favorites = const [], this.isLoading = false, this.error});

  FavoriteState copyWith({List<WordTranslation>? favorites, bool? isLoading, String? error}) {
    return FavoriteState(favorites: favorites ?? this.favorites, isLoading: isLoading ?? this.isLoading, error: error);
  }
}

/// Notifier that manages favorites list
class FavoriteNotifier extends ChangeNotifier {
  final WordService _wordService;
  FavoriteState _state = const FavoriteState();

  FavoriteNotifier(this._wordService);

  FavoriteState get state => _state;
  bool isFavorite(int wordId) {
    return _state.favorites.any((w) => w.wordId == wordId);
  }

  /// Fetch all favorite words
  Future<void> fetchFavorites(String token) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final response = await _wordService.getAllFavorites(token);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final words = data.map((e) => WordTranslation.fromJson(e)).toList();

        _state = _state.copyWith(favorites: words, isLoading: false);
      } else {
        _state = _state.copyWith(isLoading: false, error: "Failed to load favorites");
      }
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  /// Remove a word from favorites
  Future<void> removeFavorite(int wordId, String token) async {
    try {
      final response = await _wordService.deleteFavorite(wordId.toString(), token);

      if (response.statusCode == 200 || response.statusCode == 204) {
        final updated = _state.favorites.where((w) => w.wordId != wordId).toList();

        _state = _state.copyWith(favorites: updated);
        notifyListeners();
      }
    } catch (e) {
      _state = _state.copyWith(error: e.toString());
      notifyListeners();
    }
  }

  /// Optional: Add favorite
  Future<void> addFavorite(int wordId, String token) async {
    try {
      final response = await _wordService.createFavorite(wordId.toString(), token);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchFavorites(token); // refresh list
      }
    } catch (e) {
      _state = _state.copyWith(error: e.toString());
      notifyListeners();
    }
  }

  // Optimistic toggle favorite
  Future<void> toggleFavorite(int wordId, String token) async {
    final alreadyFav = isFavorite(wordId);

    // Optimistically update state
    if (alreadyFav) {
      _state = _state.copyWith(favorites: _state.favorites.where((w) => w.wordId != wordId).toList());
    } else {
      _state = _state.copyWith(favorites: [..._state.favorites]);
    }
    notifyListeners();

    // Call API
    try {
      if (alreadyFav) {
        await _wordService.deleteFavorite(wordId.toString(), token);
      } else {
        await _wordService.createFavorite(wordId.toString(), token);
      }
    } catch (e) {
      // Revert state if API fails
      await fetchFavorites(token);
    }
  }
}
