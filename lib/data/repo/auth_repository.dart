import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../service/auth_service.dart';

class AuthRepository {
  final AuthService _authService;
  final _storage = const FlutterSecureStorage();

  AuthRepository(this._authService);
  // Handle Login & Save Token
  Future<bool> login(String email, String password) async {
    final response = await _authService.login(email, password);
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save the token returned by your Node.js server
      await _storage.write(key: 'jwt_token', value: data['token']);
      return true;
    }
    return false;
  }

  // Get token for other repositories
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }
}