import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:domra_tech/model/user.dart';
import 'package:domra_tech/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  User? _user;
  String? _jwt;

  AuthProvider(this._authService);

  AuthService get authService => _authService;
  User? get user => _user;
  String? get jwt => _jwt;

  // Firebase login flow
  Future<User?> loginWithFirebase(String email, String password) async {
    final fbUser = await _authService.firebaseLogin(email, password);

    if (fbUser != null) {
      final idToken = await fbUser.getIdToken();
      if (idToken == null) throw Exception('Failed to get Firebase token');

      final response = await _authService.loginWithFirebase();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = User.fromJson(data['user']);
        notifyListeners();
        return _user;
      } else {
        throw Exception('Backend login failed: ${response.body}');
      }
    } else {
      throw Exception('Firebase login failed');
    }
  }

  Future<fb.User?> signupWithFirebase(String email, String password) async {
    final fbUser = await _authService.signupWithFirebase(email, password);
    return fbUser;
  }

  // Google sign-in flow
  Future<String?> signInWithGoogle() async {
    final token = await _authService.signInWithGoogle();
    if (token != null) {
      _jwt = token;
      notifyListeners();
      return token;
    } else {
      throw Exception("Google sign-in cancelled");
    }
  }

  Future<String?> getIdToken() async {
    return await fb.FirebaseAuth.instance.currentUser?.getIdToken();
  }

  Future<void> logout() async {
    await fb.FirebaseAuth.instance.signOut();
    _user = null;
    _jwt = null;
    notifyListeners();
  }
}
