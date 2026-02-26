import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  User? _user;

  AuthProvider(this._authService);

  User? get user => _user;

  // Firebase login flow
  Future<void> loginWithFirebase(String email, String password) async {
    // Step 1: Sign in with Firebase
    final fbUser = await _authService.firebaseLogin(email, password);

    if (fbUser != null) {
      // Step 2: Send token to backend
      final response = await _authService.loginWithFirebase();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = User.fromJson(
          data['user'],
        ); // map backend JSON to your User model
        notifyListeners();
      } else {
        throw Exception("Backend login failed: ${response.body}");
      }
    } else {
      throw Exception("Firebase login failed");
    }
  }
}
