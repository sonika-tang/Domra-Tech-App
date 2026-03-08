import 'package:flutter/foundation.dart';
import '../../model/word_translation.dart';

/// Word state model
/// Holds all word-related state for browsing and searching
class WordState {
  final List<WordTranslation> words;
  final List<WordTranslation> searchResults;
  final bool isLoading;
  final bool isSearching;
  final String? error;
  final int currentPage;
  final int totalCount;
  final String? selectedCategory;
  final String? lastSearchQuery;
  final DateTime? lastUpdated;

  const WordState({
    this.words = const [],
    this.searchResults = const [],
    this.isLoading = false,
    this.isSearching = false,
    this.error,
    this.currentPage = 1,
    this.totalCount = 0,
    this.selectedCategory,
    this.lastSearchQuery,
    this.lastUpdated,
  });

  /// Create a copy with modified fields
  WordState copyWith({
    List<WordTranslation>? words,
    List<WordTranslation>? searchResults,
    bool? isLoading,
    bool? isSearching,
    String? error,
    int? currentPage,
    int? totalCount,
    String? selectedCategory,
    String? lastSearchQuery,
    DateTime? lastUpdated,
  }) {
    return WordState(
      words: words ?? this.words,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      lastSearchQuery: lastSearchQuery ?? this.lastSearchQuery,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Clear error message
  WordState clearError() => copyWith(error: null);

  /// Set loading state
  WordState withLoading({bool searching = false}) =>
      copyWith(isLoading: true, isSearching: searching, error: null);

  /// Check if data is stale (older than 30 minutes)
  bool get isStale {
    if (lastUpdated == null) return true;
    final difference = DateTime.now().difference(lastUpdated!);
    return difference.inMinutes > 30;
  }
}

/// Word state notifier
/// Manages all word-related operations
class WordNotifier extends ChangeNotifier {
  WordState _state = const WordState();

  WordState get state => _state;

  /// Update state and notify listeners
  void _setState(WordState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Fetch all words
  Future<bool> fetchWords() async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock data
      final words = [
        WordTranslation(
          wordId: 1,
          englishWord: 'Software',
          khmerWord: 'សូលវែEr',
          frenchWord: 'Logiciel',
          definition: 'Computer programs and operating systems',
          example: 'The software is running smoothly',
        ),
        WordTranslation(
          wordId: 2,
          englishWord: 'Database',
          khmerWord: 'មូលដ្ឋានទិន្នន័យ',
          frenchWord: 'Base de données',
          definition: 'Organized collection of data',
          example: 'The database contains user information',
        ),
        WordTranslation(
          wordId: 3,
          englishWord: 'API',
          khmerWord: 'ចលនាលម្អិត',
          frenchWord: 'Interface de programmation',
          definition: 'Application Programming Interface',
          example: 'Use the API to integrate services',
        ),
      ];

      _setState(
        state.copyWith(
          words: words,
          isLoading: false,
          error: null,
          totalCount: words.length,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to fetch words: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Search words by query
  Future<bool> searchWords(String query) async {
    try {
      if (query.isEmpty) {
        _setState(state.copyWith(searchResults: [], lastSearchQuery: null));
        return true;
      }

      _setState(state.withLoading(searching: true));

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock search results
      final results = state.words
          .where(
            (word) =>
                word.englishWord?.toLowerCase().contains(query.toLowerCase()) ??
                false ||
                    word.khmerWord.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    word.frenchWord!.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();

      _setState(
        state.copyWith(
          searchResults: results,
          isLoading: false,
          isSearching: false,
          error: null,
          lastSearchQuery: query,
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          isSearching: false,
          error: 'Search failed: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Clear search results
  void clearSearch() {
    _setState(state.copyWith(searchResults: [], lastSearchQuery: null));
  }

  /// Filter words by category
  void filterByCategory(String category) {
    _setState(state.copyWith(selectedCategory: category));
  }

  /// Clear category filter
  void clearCategoryFilter() {
    _setState(state.copyWith(selectedCategory: null));
  }

  /// Clear error message
  void clearError() {
    _setState(state.clearError());
  }

  /// Refresh words data
  Future<bool> refresh() async {
    return await fetchWords();
  }

  /// Load next page of words
  Future<bool> loadNextPage() async {
    try {
      _setState(state.withLoading());

      await Future.delayed(const Duration(milliseconds: 600));

      final nextPage = state.currentPage + 1;
      final newWords = [...state.words];

      // Add mock data for next page
      newWords.addAll([
        WordTranslation(
          wordId: 4,
          englishWord: 'Framework',
          khmerWord: 'ក្របាច់ការ',
          frenchWord: 'Cadre de travail',
          definition: 'Reusable set of libraries or code',
          example: 'Flutter is a cross-platform framework',
        ),
      ]);

      _setState(
        state.copyWith(
          words: newWords,
          isLoading: false,
          currentPage: nextPage,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load next page: ${e.toString()}',
        ),
      );
      return false;
    }
  }
}
