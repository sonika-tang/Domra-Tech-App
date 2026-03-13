import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Use this instead of dart:io
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../model/payment.dart';

class PaymentService {
  final http.Client client;

  // Since you are running ONLY on browser:
  // "localhost" is correct for reaching your Node.js server on the same machine.
  final String baseUrl = "http://localhost:3000/api";

  PaymentService(this.client);

  Future<PaymentModel> generateBakongQR(
    double amount,
    String currency,
    String token,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/payments/bakong/generate-qr'),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token', // Uncomment when ready
        },
        body: jsonEncode({'amount': amount, 'currency': currency}),
      );

      if (response.statusCode == 201) {
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

  Future<String> checkStatus(int paymentId, String token) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/payments/bakong/status/$paymentId'),
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
