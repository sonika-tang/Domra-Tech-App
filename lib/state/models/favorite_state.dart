import 'package:flutter/foundation.dart';
import '../../model/favorite.dart';

/// Favorite state model
/// Holds all favorite-related state
class FavoriteState {
  final List<Favorite> favorites;
  final Set<int> favoriteWordIds;
  final bool isLoading;
  final String? error;
  final DateTime? lastUpdated;

  const FavoriteState({
    this.favorites = const [],
    this.favoriteWordIds = const {},
    this.isLoading = false,
    this.error,
    this.lastUpdated,
  });

  /// Create a copy with modified fields
  FavoriteState copyWith({
    List<Favorite>? favorites,
    Set<int>? favoriteWordIds,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      favoriteWordIds: favoriteWordIds ?? this.favoriteWordIds,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Clear error message
  FavoriteState clearError() => copyWith(error: null);

  /// Set loading state
  FavoriteState withLoading() => copyWith(isLoading: true, error: null);

  /// Check if a word is favorited
  bool isFavorited(int wordId) => favoriteWordIds.contains(wordId);

  /// Get count of favorites
  int get count => favorites.length;
}

/// Favorite state notifier
/// Manages all favorite-related operations
class FavoriteNotifier extends ChangeNotifier {
  FavoriteState _state = const FavoriteState();

  FavoriteState get state => _state;

  /// Update state and notify listeners
  void _setState(FavoriteState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Fetch all favorites
  Future<bool> fetchFavorites() async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock favorites data
      final favorites = [
        Favorite(userId: 1, wordId: 1),
        Favorite(userId: 1, wordId: 3),
      ];

      final favoriteWordIds = favorites.map((f) => f.wordId).toSet();

      _setState(
        state.copyWith(
          favorites: favorites,
          favoriteWordIds: favoriteWordIds,
          isLoading: false,
          error: null,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to fetch favorites: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Add word to favorites
  Future<bool> addFavorite(int wordId, int userId) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 400));

      final newFavorite = Favorite(userId: userId, wordId: wordId);
      final updatedFavorites = [...state.favorites, newFavorite];
      final updatedFavoriteIds = {...state.favoriteWordIds, wordId};

      _setState(
        state.copyWith(
          favorites: updatedFavorites,
          favoriteWordIds: updatedFavoriteIds,
          isLoading: false,
          error: null,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to add favorite: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Remove word from favorites
  Future<bool> removeFavorite(int wordId) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 400));

      final updatedFavorites = state.favorites
          .where((f) => f.wordId != wordId)
          .toList();
      final updatedFavoriteIds = {...state.favoriteWordIds};
      updatedFavoriteIds.remove(wordId);

      _setState(
        state.copyWith(
          favorites: updatedFavorites,
          favoriteWordIds: updatedFavoriteIds,
          isLoading: false,
          error: null,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to remove favorite: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Toggle favorite status for a word
  Future<bool> toggleFavorite(int wordId, int userId) async {
    if (state.isFavorited(wordId)) {
      return await removeFavorite(wordId);
    } else {
      return await addFavorite(wordId, userId);
    }
  }

  /// Clear error message
  void clearError() {
    _setState(state.clearError());
  }

  /// Clear all favorites
  void clearAllFavorites() {
    _setState(const FavoriteState());
  }
}
