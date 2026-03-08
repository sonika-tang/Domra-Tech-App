import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:domra_tech/model/user.dart';
import 'package:domra_tech/service/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  User? _user;

  AuthProvider(this._authService);

  User? get user => _user;

  // Firebase login flow
  Future<void> loginWithFirebase(String email, String password) async {
    final fbUser = await _authService.firebaseLogin(email, password);

    if (fbUser != null) {
      final idToken = await fbUser.getIdToken();

      if (idToken == null) {
        throw Exception('Failed to get Firebase token');
      }
      final response = await _authService.loginWithFirebase();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = User.fromJson(data['user']);
        notifyListeners();
      } else {
        throw Exception('Backend login failed: ${response.body}');
      }
    } else {
      throw Exception('Firebase login failed');
    }
  }

  // Get the current Firebase ID token for API calls
  Future<String?> getIdToken() async {
    return await fb.FirebaseAuth.instance.currentUser?.getIdToken();
  }

  // Logout: signs out from Firebase and clears state
  Future<void> logout() async {
    await fb.FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}
