import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:domra_tech/model/user.dart';
import 'package:domra_tech/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final _storage = const FlutterSecureStorage();

  User? _user;
  String? _jwt;

  AuthProvider(this._authService);

  User? get user => _user;
  String? get jwt => _jwt;

  // -------------------------------------------------------
  // EMAIL / PASSWORD LOGIN
  // -------------------------------------------------------
  Future<User?> loginWithFirebase(String email, String password) async {
    final fbUser = await _authService.firebaseLogin(email, password);
    if (fbUser == null) throw Exception("Firebase login failed");

    final response = await _authService.loginWithFirebase();
    if (response.statusCode != 200) {
      throw Exception("Backend login failed: ${response.body}");
    }

    final data = jsonDecode(response.body);
    _user = User.fromJson(data['user']);
    _jwt = data['jwt'];

    await _storage.write(key: "jwt", value: _jwt);

    notifyListeners();
    return _user;
  }

  // EMAIL / PASSWORD SIGNUP
  Future<fb.User?> signupWithFirebase({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gender,
    required String dob,
  }) async {
    final fbUser = await _authService.signupWithFirebase(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      dob: dob,
    );

    // After signup, call backend login to get JWT
    final response = await _authService.loginWithFirebase();
    if (response.statusCode != 200) {
      throw Exception("Backend signup failed: ${response.body}");
    }

    final data = jsonDecode(response.body);
    _user = User.fromJson(data['user']);
    _jwt = data['jwt'];

    await _storage.write(key: "jwt", value: _jwt);
    notifyListeners();

    return fbUser;
  }

  // -------------------------------------------------------
  // GOOGLE SIGN-IN
  // -------------------------------------------------------
  Future<String?> signInWithGoogle() async {
    final fbUser = await _authService.signInWithGoogle();
    if (fbUser == null) throw Exception("Google sign-in failed");

    final token = await fbUser.getIdToken();
    final response = await _authService.loginWithFirebase();

    if (response.statusCode != 200) {
      throw Exception("Backend Google login failed: ${response.body}");
    }

    final data = jsonDecode(response.body);
    _jwt = data['jwt'];
    _user = User.fromJson(data['user']);

    await _storage.write(key: "jwt", value: _jwt);

    notifyListeners();
    return _jwt;
  }

  // -------------------------------------------------------
  // HELPERS
  // -------------------------------------------------------
  Future<String?> getIdToken() async {
    return await fb.FirebaseAuth.instance.currentUser?.getIdToken();
  }

  Future<void> logout() async {
    await fb.FirebaseAuth.instance.signOut();
    await _storage.delete(key: "jwt");

    _user = null;
    _jwt = null;

    notifyListeners();
  }

  Future<void> loadStoredToken() async {
    _jwt = await _storage.read(key: "jwt");
    notifyListeners();
  }
}
