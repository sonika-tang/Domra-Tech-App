import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/constants.dart';

class UserService {
  final http.Client client;
  UserService(this.client);

  Future<http.Response> getProfile(String token) async {
    return await client.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<http.Response> updateProfile(
    Map<String, dynamic> data,
    String token,
  ) async {
    return await client.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }

  Future<http.Response> changePassword(
    Map<String, dynamic> data,
    String token,
  ) async {
    return await client.put(
      Uri.parse('$baseUrl/profile/password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }
}
