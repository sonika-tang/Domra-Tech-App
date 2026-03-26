import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../model/word_request.dart';
import '../../model/correction_request.dart';
import '../../service/request_service.dart';
import '../../service/firebase_storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final RequestService _requestService;
  final FirebaseStorageService _storageService = FirebaseStorageService();

  ContributionNotifier(this._requestService);

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

      final token = await const FlutterSecureStorage().read(key: 'jwt');
      if (token == null) {
        _setState(state.copyWith(isLoading: false, error: 'Not authenticated.'));
        return false;
      }

      final responses = await Future.wait([
        _requestService.getWordRequests(token),
        _requestService.getMyCorrections(token),
      ]);

      // parse word requests
      final wrRes = responses[0];
      List<WordRequest> wordRequests = [];
      if (wrRes.statusCode == 200) {
        final body = jsonDecode(wrRes.body);
        final list = body is List ? body : (body['data'] ?? body['wordRequests'] ?? []);
        wordRequests = (list as List).map((e) => WordRequest.fromJson(e as Map<String, dynamic>)).toList();
      }

      // parse corrections
      final crRes = responses[1];
      List<CorrectionRequest> corrections = [];
      if (crRes.statusCode == 200) {
        final body = jsonDecode(crRes.body);
        final list = body is List ? body : (body['data'] ?? body['correctionRequests'] ?? []);
        corrections = (list as List).map((e) => CorrectionRequest.fromJson(e as Map<String, dynamic>)).toList();
      }

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
  Future<bool> submitWordRequest(Map<String, dynamic> wordData, {XFile? imageFile}) async {
    try {
      _setState(state.withLoading());

      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _storageService.uploadImage(imageFile, 'word_requests');
        if (imageUrl != null) {
          wordData['imageURL'] = imageUrl; 
        }
      }

      final token = await const FlutterSecureStorage().read(key: 'jwt');
      if (token == null) throw Exception("Authentication token is missing.");

      final response = await _requestService.createWordRequest(wordData, token);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final newRequest = WordRequest.fromJson(responseData);
        
        final updatedWordRequests = List<WordRequest>.from(state.wordRequests)..insert(0, newRequest);

        _setState(
          state.copyWith(
            wordRequests: updatedWordRequests,
            isLoading: false,
            error: null,
            submissionStatus: SubmissionStatus.success,
            lastUpdated: DateTime.now(),
          ),
        );

        // Reset status after a delay
        Future.delayed(const Duration(seconds: 2), () {
          _setState(state.copyWith(submissionStatus: SubmissionStatus.idle));
        });

        return true;
      } else {
        throw Exception("Status ${response.statusCode}: ${response.body}");
      }
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
  Future<bool> submitCorrection(Map<String, dynamic> correctionData, {XFile? imageFile}) async {
    try {
      _setState(state.withLoading());

      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _storageService.uploadImage(imageFile, 'corrections');
        if (imageUrl != null) {
          correctionData['imageURL'] = imageUrl; 
        }
      }

      final token = await const FlutterSecureStorage().read(key: 'jwt');
      if (token == null) throw Exception("Authentication token is missing.");

      debugPrint('--- SUBMITTING CORRECTION REQUEST ---');
      debugPrint('Payload: $correctionData');

      final response = await _requestService.createCorrectionRequest(correctionData, token);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final newCorrection = CorrectionRequest.fromJson(responseData);
        
        final updatedCorrections = List<CorrectionRequest>.from(state.corrections)..insert(0, newCorrection);

        _setState(
          state.copyWith(
            corrections: updatedCorrections,
            isLoading: false,
            error: null,
            submissionStatus: SubmissionStatus.success,
            lastUpdated: DateTime.now(),
          ),
        );

        // Reset status after a delay
        Future.delayed(const Duration(seconds: 2), () {
          _setState(state.copyWith(submissionStatus: SubmissionStatus.idle));
        });

        return true;
      } else {
        debugPrint('--- CORRECTION REQUEST FAILED ---');
        debugPrint('Status: ${response.statusCode}  Body: ${response.body}');
        throw Exception('Status ${response.statusCode}: ${response.body}');
      }
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
