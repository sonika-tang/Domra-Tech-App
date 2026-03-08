import 'package:flutter/foundation.dart';
import '../../../model/user.dart';

/// Authentication state model
/// Holds all authentication-related state
class AuthState {
  final User? user;
  final String? token;
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;
  final DateTime? tokenExpiresAt;
  final bool isFirstTime;

  const AuthState({
    this.user,
    this.token,
    this.isLoggedIn = false,
    this.isLoading = false,
    this.error,
    this.tokenExpiresAt,
    this.isFirstTime = true,
  });

  /// Create a copy with modified fields
  AuthState copyWith({
    User? user,
    String? token,
    bool? isLoggedIn,
    bool? isLoading,
    String? error,
    DateTime? tokenExpiresAt,
    bool? isFirstTime,
  }) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      tokenExpiresAt: tokenExpiresAt ?? this.tokenExpiresAt,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  /// Clear error message
  AuthState clearError() => copyWith(error: null);

  /// Set loading state
  AuthState withLoading() => copyWith(isLoading: true, error: null);

  /// Check if token is expired
  bool get isTokenExpired {
    if (tokenExpiresAt == null) return false;
    return DateTime.now().isAfter(tokenExpiresAt!);
  }

  /// Check if token will expire soon (within 5 minutes)
  bool get isTokenExpiringSoon {
    if (tokenExpiresAt == null) return false;
    final expiryThreshold = DateTime.now().add(const Duration(minutes: 5));
    return DateTime.now().isBefore(tokenExpiresAt!) &&
        tokenExpiresAt!.isBefore(expiryThreshold);
  }
}

/// Authentication state notifier
/// Manages all authentication-related operations
class AuthNotifier extends ChangeNotifier {
  AuthState _state = const AuthState();

  AuthState get state => _state;

  /// Update state and notify listeners
  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    try {
      _setState(state.withLoading());

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock successful login
      final user = User(
        userId: 1,
        email: email,
        firstName: 'John',
        lastName: 'Doe',
        role: 'user',
        status: 'active',
      );

      final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      final expiresAt = DateTime.now().add(const Duration(hours: 24));

      _setState(
        state.copyWith(
          user: user,
          token: token,
          isLoggedIn: true,
          isLoading: false,
          error: null,
          tokenExpiresAt: expiresAt,
          isFirstTime: false,
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Login failed: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Register a new user
  Future<bool> register(Map<String, dynamic> userData) async {
    try {
      _setState(state.withLoading());

      await Future.delayed(const Duration(milliseconds: 500));

      final user = User(
        userId: 2,
        email: userData['email'] as String,
        firstName: userData['firstName'] as String,
        lastName: userData['lastName'] as String,
        role: 'user',
        status: 'active',
      );

      final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      final expiresAt = DateTime.now().add(const Duration(hours: 24));

      _setState(
        state.copyWith(
          user: user,
          token: token,
          isLoggedIn: true,
          isLoading: false,
          error: null,
          tokenExpiresAt: expiresAt,
          isFirstTime: false,
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Registration failed: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Request password reset
  Future<bool> forgotPassword(String email) async {
    try {
      _setState(state.withLoading());

      await Future.delayed(const Duration(milliseconds: 500));

      _setState(state.copyWith(isLoading: false, error: null));

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to send reset email: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Reset password with token
  Future<bool> resetPassword(String newPassword, String token) async {
    try {
      _setState(state.withLoading());

      await Future.delayed(const Duration(milliseconds: 500));

      _setState(state.copyWith(isLoading: false, error: null));

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to reset password: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Logout current user
  void logout() {
    _setState(const AuthState());
  }

  /// Clear error message
  void clearError() {
    _setState(state.clearError());
  }

  /// Check and refresh token if needed
  Future<void> checkTokenValidity() async {
    if (state.isTokenExpired) {
      logout();
    } else if (state.isTokenExpiringSoon) {
      await refreshToken();
    }
  }

  /// Refresh authentication token
  Future<bool> refreshToken() async {
    try {
      _setState(state.withLoading());

      await Future.delayed(const Duration(milliseconds: 300));

      _setState(
        state.copyWith(
          isLoading: false,
          tokenExpiresAt: DateTime.now().add(const Duration(hours: 1)),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Token refresh failed: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Mark first time as false (after onboarding)
  void completeOnboarding() {
    _setState(state.copyWith(isFirstTime: false));
  }
}
