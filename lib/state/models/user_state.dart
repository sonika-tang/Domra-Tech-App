import 'package:flutter/foundation.dart';
import '../../model/user.dart';

/// User state model
/// Holds user profile-related state
class UserState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isEditing;
  final DateTime? lastUpdated;

  const UserState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isEditing = false,
    this.lastUpdated,
  });

  /// Create a copy with modified fields
  UserState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isEditing,
    DateTime? lastUpdated,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isEditing: isEditing ?? this.isEditing,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Clear error message
  UserState clearError() => copyWith(error: null);

  /// Set loading state
  UserState withLoading() => copyWith(isLoading: true, error: null);

  /// Get user full name
  String get userFullName {
    if (user == null) return 'Guest';
    final firstName = user?.firstName ?? '';
    final lastName = user?.lastName ?? '';
    return '$firstName $lastName'.trim();
  }

  /// Check if user is active
  bool get isActive => user?.status == 'active';
}

/// User state notifier
/// Manages user profile operations
class UserNotifier extends ChangeNotifier {
  UserState _state = const UserState();

  UserState get state => _state;

  /// Update state and notify listeners
  void _setState(UserState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Fetch user profile
  Future<bool> fetchUserProfile(String token) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock user data
      final user = User(
        userId: 1,
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
        profileURL: null,
        role: 'user',
        status: 'active',
      );

      _setState(
        state.copyWith(
          user: user,
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
          error: 'Failed to fetch user profile: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Update user profile
  Future<bool> updateUserProfile(
    Map<String, dynamic> updates,
    String token,
  ) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 700));

      // Update local user data
      if (state.user != null) {
        final updatedUser = User(
          userId: state.user!.userId,
          email: updates['email'] as String? ?? state.user!.email,
          firstName: updates['firstName'] as String? ?? state.user!.firstName,
          lastName: updates['lastName'] as String? ?? state.user!.lastName,
          profileURL:
              updates['profileURL'] as String? ?? state.user!.profileURL,
          role: state.user!.role,
          status: state.user!.status,
          googleId: state.user!.googleId,
        );

        _setState(
          state.copyWith(
            user: updatedUser,
            isLoading: false,
            error: null,
            isEditing: false,
            lastUpdated: DateTime.now(),
          ),
        );

        return true;
      }

      return false;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to update profile: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Change user password
  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
    String token,
  ) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 700));

      _setState(
        state.copyWith(
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
          error: 'Failed to change password: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Set editing mode
  void setEditingMode(bool isEditing) {
    _setState(state.copyWith(isEditing: isEditing));
  }

  /// Clear error message
  void clearError() {
    _setState(state.clearError());
  }

  /// Update profile picture
  Future<bool> uploadProfilePicture(String imagePath, String token) async {
    try {
      _setState(state.withLoading());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      if (state.user != null) {
        final updatedUser = User(
          userId: state.user!.userId,
          email: state.user!.email,
          firstName: state.user!.firstName,
          lastName: state.user!.lastName,
          profileURL: imagePath, // In real app, this would be the uploaded URL
          role: state.user!.role,
          status: state.user!.status,
          googleId: state.user!.googleId,
        );

        _setState(
          state.copyWith(
            user: updatedUser,
            isLoading: false,
            error: null,
            lastUpdated: DateTime.now(),
          ),
        );

        return true;
      }

      return false;
    } catch (e) {
      _setState(
        state.copyWith(
          isLoading: false,
          error: 'Failed to upload profile picture: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Refresh user profile
  Future<bool> refresh(String token) async {
    return await fetchUserProfile(token);
  }

  /// Clear user data (on logout)
  void clearUserData() {
    _setState(const UserState());
  }
}
