import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/constants.dart';

class RequestService {
  final http.Client client;
  RequestService(this.client);

  Future<http.Response> createWordRequest(
    Map<String, dynamic> data,
    String token,
  ) async {
    return await client.post(
      // FIXED: Changed word-requests to wordRequests
      Uri.parse('$baseUrl/wordRequests'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }

  Future<http.Response> updateWordRequest(
    String id,
    Map<String, dynamic> data,
    String token,
  ) async {
    return await client.put(
      // FIXED: Changed word-requests to wordRequests
      Uri.parse('$baseUrl/wordRequests/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }

  Future<http.Response> deleteWordRequest(String id, String token) async {
    return await client.delete(
      Uri.parse('$baseUrl/wordRequests/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<http.Response> createCorrectionRequest(
    Map<String, dynamic> data,
  ) async {
    return await client.post(
      Uri.parse('$baseUrl/correctionRequests'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  Future<http.Response> getCorrectionById(String id) async {
    return await client.get(
      // FIXED: Changed correction-requests to correctionRequests
      Uri.parse('$baseUrl/correctionRequests/$id'),
    );
  }

  Future<http.Response> updateCorrection(
    String id,
    Map<String, dynamic> data,
  ) async {
    return await client.put(
      // FIXED: Changed correction-requests to correctionRequests
      Uri.parse('$baseUrl/correctionRequests/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }
}
