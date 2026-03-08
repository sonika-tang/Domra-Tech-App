import 'dart:convert'; // Essential for jsonEncode
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; // Helpful for Google OAuth
import '../core/config/constants.dart';

class AuthService {
  final http.Client client;
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;
  AuthService(this.client);

  //Firebase Email/Password sign-in
  Future<fb.User?> firebaseLogin(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  //Send Firebase ID token to backend
  Future<http.Response> loginWithFirebase() async {
    final token = await _firebaseAuth.currentUser?.getIdToken(true);
    print("Firebase ID Token: $token");
    return await client.post(
      Uri.parse('$baseUrl/auth/firebase-login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

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

  // Google Authentication
  // Since Node route redirects the browser, Flutter uses a URL launcher
  Future<void> initiateGoogleLogin() async {
    final url = Uri.parse('$baseUrl/auth/google');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Google Login');
    }
  }
}
