import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../core/config/constants.dart';

class AuthService {
  final http.Client client;
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "2457929257-bpmmhnns2un9v6do63ks7ico2gqk16e5.apps.googleusercontent.com",
  );
  AuthService(this.client);

  // Firebase Email/Password login
  Future<fb.User?> firebaseLogin(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // Send Firebase ID token to backend
  Future<http.Response> loginWithFirebase() async {
    final token = await _firebaseAuth.currentUser?.getIdToken(true);
    print("Firebase ID Token: $token");
    if (token == null) throw Exception("No Firebase user logged in");

    return await client.post(
      Uri.parse('$baseUrl/auth/firebase-login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  // Traditional backend register
  Future<http.Response> register(Map<String, dynamic> userData) async {
    return await client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
  }

  // Traditional backend login
  Future<http.Response> login(String email, String password) async {
    return await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // Google Sign-In → backend
  Future<String?> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final auth = await account.authentication;
    final idToken = auth.idToken;

    final response = await client.post(
      Uri.parse('$baseUrl/auth/googleRegister'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': idToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // backend JWT
    } else {
      throw Exception("Backend error: ${response.body}");
    }
  }

  Future<fb.User?> signupWithFirebase(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Optionally send UID + email to backend
    await client.post(
      Uri.parse("$baseUrl/auth/firebase-signup"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "uid": credential.user?.uid,
        "email": credential.user?.email,
      }),
    );

    return credential.user;
  }

  Future<void> initGoogleSignIn() async {
    // Try silent sign-in first
    final account = await _googleSignIn.signInSilently();
    if (account != null) {
      print("Already signed in: ${account.email}");
    }

    // Forgot password
    Future<http.Response> forgotPassword(String email) async {
      return await client.post(
        Uri.parse('$baseUrl/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
    }

    // Reset password
    Future<http.Response> resetPassword(
      String newPassword,
      String token,
    ) async {
      return await client.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'password': newPassword, 'token': token}),
      );
    }
  }
}
