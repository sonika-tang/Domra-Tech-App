import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Use this instead of dart:io
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../model/payment.dart';
import '../core/config/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentService {
  final http.Client client;

  // Since you are running ONLY on browser:
  // "localhost" is correct for reaching your Node.js server on the same machine.
  static const String devBaseUrl = "http://localhost:3000/api";
  static const String prodBaseUrl = "https://api.domratech.store/api";

  final String baseUrl = prodBaseUrl;

  PaymentService(this.client);

  Future<String> _getBestToken() async {
    const storage = FlutterSecureStorage();
    final savedToken = await storage.read(key: 'jwt');

    // If no one is logged in, use the admin "ghost" token for testing
    return savedToken ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsInVpZCI6ImVvNjl3QXpKVHlUaHhlRXFWb2EzUjZ6ak5uNzMiLCJlbWFpbCI6ImFkbWluQGV4YW1wbGUuY29tIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NzQ5NTAyNDgsImV4cCI6MTc3NTU1NTA0OH0.yoBrMmd_8iKrBJESUsHqKTierRXkp9Trtz-hFSOyI4k";
  }

  Future<PaymentModel> generateBakongQR(
    double amount,
    String currency,
  ) async {
    try {
      // Fetch the token dynamically inside the method
      final token = await _getBestToken();

      final response = await client.post(
        Uri.parse('$baseUrl/payments/bakong/generate-qr'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'amount': amount, 'currency': currency}),
      );

      if (response.statusCode == 201) {
        print("RAW BODY: ${response.body}");
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PaymentModel.fromJson(data);
      } else {
        final error = jsonDecode(response.body);
        throw error['message'] ?? 'Failed to generate QR';
      }
    } catch (e) {
      throw 'Server Connection Error: $e';
    }
  }

  Future<String> checkStatus(int paymentId) async {
    try {
      final token = await _getBestToken(); 
      final response = await client.get(
        Uri.parse('$baseUrl/payments/bakong/status/$paymentId'),
        headers: {
          'Authorization':
              'Bearer $token', // Most backends need this for status too!
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] ?? 'pending';
      }
    } catch (e) {
      return 'pending';
    }
    return 'pending';
  }

  Future<bool> launchBakongApp(String deepLink) async {
    final Uri url = Uri.parse(deepLink);

    // Note: On Desktop browsers, this will usually return false
    // because the Bakong App isn't installed on Windows/macOS.
    try {
      return await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Could not launch app: $e");
      return false;
    }
  }

}