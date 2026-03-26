import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import '../core/config/constants.dart';

class AuthService {
  final http.Client client;
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['openid', 'email', 'profile'],
    clientId: kIsWeb
        ? "2457929257-bpmmhnns2un9v6do63ks7ico2gqk16e5.apps.googleusercontent.com"
        : null,
  );

  AuthService(this.client);

  // ===========================================================================
  // EMAIL / PASSWORD AUTHENTICATION
  // ===========================================================================

  Future<fb.User?> signupWithFirebase({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gender,
    required String dob,
  }) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final token = await result.user?.getIdToken();
    await client.post(
      Uri.parse("$baseUrl/auth/firebase-signup"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "firebaseToken": token,
        "email": result.user?.email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "dob": dob,
      }),
    );

    return result.user;
  }

  Future<fb.User?> firebaseLogin(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<http.Response> loginWithFirebase() async {
    final token = await _firebaseAuth.currentUser?.getIdToken(true);
    if (token == null) throw Exception("No Firebase user logged in");
    debugPrint("Firebase ID Token: $token");

    return await client.post(
      Uri.parse('$baseUrl/auth/firebase-login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  // ===========================================================================
  // GOOGLE AUTHENTICATION
  // ===========================================================================

  Future<fb.User?> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) throw Exception("Cancelled");

    final auth = await account.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    final idToken = await userCredential.user?.getIdToken();

    final response = await client.post(
      Uri.parse('$baseUrl/auth/googleRegister'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': idToken}),
    );

    if (response.statusCode != 200) {
      throw Exception("Backend Google login failed: ${response.body}");
    }

    return userCredential.user;
  }

  // ===========================================================================
  // TRADITIONAL BACKEND AUTH
  // ===========================================================================

  Future<http.Response> register(Map<String, dynamic> userData) async {
    return await client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
  }

  Future<http.Response> login(String email, String password) async {
    return await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // ===========================================================================
  // PASSWORD RECOVERY
  // ===========================================================================

  Future<http.Response> forgotPassword(String email) async {
    return await client.post(
      Uri.parse('$baseUrl/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  Future<http.Response> resetPassword(String newPassword, String token) async {
    return await client.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'password': newPassword, 'token': token}),
    );
  }
}
