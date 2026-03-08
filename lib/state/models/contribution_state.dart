import 'package:flutter/foundation.dart';
import '../../model/word_request.dart';
import '../../model/correction_request.dart';

/// Contribution state model
/// Holds all contribution-related state (WordRequest & CorrectionRequest)
class ContributionState {
  final List<WordRequest> wordRequests;
  final List<CorrectionRequest> corrections;
  final bool isLoading;
  final String? error;
  final SubmissionStatus submissionStatus;
  final int totalContributions;
  final DateTime? lastUpdated;

  const ContributionState({
    this.wordRequests = const [],
    this.corrections = const [],
    this.isLoading = false,
    this.error,
    this.submissionStatus = SubmissionStatus.idle,
    this.totalContributions = 0,
    this.lastUpdated,
  });

  /// Create a copy with modified fields
  ContributionState copyWith({
    List<WordRequest>? wordRequests,
    List<CorrectionRequest>? corrections,
    bool? isLoading,
    String? error,
    SubmissionStatus? submissionStatus,
    int? totalContributions,
    DateTime? lastUpdated,
  }) {
    return ContributionState(
      wordRequests: wordRequests ?? this.wordRequests,
      corrections: corrections ?? this.corrections,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      totalContributions: totalContributions ?? this.totalContributions,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Clear error message
  ContributionState clearError() => copyWith(error: null);

  /// Set loading state
  ContributionState withLoading() =>
      copyWith(isLoading: true, submissionStatus: SubmissionStatus.loading);

  /// Get all contributions combined
  int get allContributionsCount => wordRequests.length + corrections.length;

  /// Count pending word requests
  int get pendingWordRequests =>
      wordRequests.where((w) => w.status == 'pending').length;

  /// Count pending corrections
  int get pendingCorrections =>
      corrections.where((c) => c.status == 'pending').length;

  /// Count approved word requests
  int get approvedWordRequests =>
      wordRequests.where((w) => w.status == 'approved').length;
}

/// Contribution state notifier
/// Manages all contribution-related operations
class ContributionNotifier extends ChangeNotifier {
  ContributionState _state = const ContributionState();

  ContributionState get state => _state;

  /// Update state and notify listeners
  void _setState(ContributionState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Fetch all contributions
  Future<bool> fetchContributions() async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 700));

      // Mock data
      final wordRequests = [
        WordRequest(
          wordRequestId: 1,
          newEnglishWord: 'Cloud',
          newKhmerWord: 'ពពក',
          userId: 1,
          status: 'pending',
          check: false,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        WordRequest(
          wordRequestId: 2,
          newEnglishWord: 'Backend',
          newKhmerWord: 'អភិវឌ្ឍផ្នែកខាងក្រោយ',
          userId: 1,
          status: 'approved',
          check: true,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];

      final corrections = [
        CorrectionRequest(
          correctionId: 1,
          userId: 1,
          wordId: 1,
          correctEnglishWord: 'Software Engineering',
          status: 'pending',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      _setState(
        state.copyWith(
          wordRequests: wordRequests,
          corrections: corrections,
          isLoading: false,
          error: null,
          totalContributions: wordRequests.length + corrections.length,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to fetch contributions: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Submit a new word request
  Future<bool> submitWordRequest(Map<String, dynamic> wordData) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      final newRequest = WordRequest(
        wordRequestId: state.wordRequests.length + 1,
        newEnglishWord: wordData['englishWord'] as String,
        newKhmerWord: wordData['khmerWord'] as String,
        newFrenchWord: wordData['frenchWord'] as String?,
        newDefinition: wordData['definition'] as String?,
        newExample: wordData['example'] as String?,
        reference: wordData['reference'] as String?,
        userId: 1, // Should come from auth state
        status: 'pending',
        check: false,
        createdAt: DateTime.now(),
      );

      final updatedRequests = [...state.wordRequests, newRequest];

      _setState(
        state.copyWith(
          wordRequests: updatedRequests,
          isLoading: false,
          error: null,
          submissionStatus: SubmissionStatus.success,
          totalContributions: updatedRequests.length + state.corrections.length,
          lastUpdated: DateTime.now(),
        ),
      );

      // Reset status after a delay
      Future.delayed(const Duration(seconds: 2), () {
        _setState(state.copyWith(submissionStatus: SubmissionStatus.idle));
      });

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to submit word request: ${e.toString()}',
          submissionStatus: SubmissionStatus.error,
        ),
      );
      return false;
    }
  }

  /// Submit a correction request
  Future<bool> submitCorrection(Map<String, dynamic> correctionData) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 700));

      final newCorrection = CorrectionRequest(
        correctionId: state.corrections.length + 1,
        userId: 1, // Should come from auth state
        wordId: correctionData['wordId'] as int,
        correctEnglishWord: correctionData['correctEnglish'] as String?,
        correctKhmerWord: correctionData['correctKhmer'] as String?,
        correctFrenchWord: correctionData['correctFrench'] as String?,
        reference: correctionData['reference'] as String?,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      final updatedCorrections = [...state.corrections, newCorrection];

      _setState(
        state.copyWith(
          corrections: updatedCorrections,
          isLoading: false,
          error: null,
          submissionStatus: SubmissionStatus.success,
          totalContributions:
              state.wordRequests.length + updatedCorrections.length,
          lastUpdated: DateTime.now(),
        ),
      );

      // Reset status after a delay
      Future.delayed(const Duration(seconds: 2), () {
        _setState(state.copyWith(submissionStatus: SubmissionStatus.idle));
      });

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to submit correction: ${e.toString()}',
          submissionStatus: SubmissionStatus.error,
        ),
      );
      return false;
    }
  }

  /// Get word requests only
  List<WordRequest> getWordRequests() => state.wordRequests;

  /// Get corrections only
  List<CorrectionRequest> getCorrections() => state.corrections;

  /// Clear error message
  void clearError() {
    _setState(state.clearError());
  }

  /// Clear submission status
  void clearSubmissionStatus() {
    _setState(state.copyWith(submissionStatus: SubmissionStatus.idle));
  }

  /// Refresh contributions
  Future<bool> refresh() async {
    return await fetchContributions();
  }
}

/// Submission status enum
enum SubmissionStatus { idle, loading, success, error }
