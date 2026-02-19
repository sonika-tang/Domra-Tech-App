import 'dart:convert'; // Essential for jsonEncode
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; // Helpful for Google OAuth
import '../core/config/constants.dart';

class AuthService {
  final http.Client client;
  AuthService(this.client);

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
