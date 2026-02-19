import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/constants.dart';

class PaymentService {
  final http.Client client;
  PaymentService(this.client);

  Future<http.Response> generateBakongQR(double amount, String token) async {
    return await client.post(
      Uri.parse('$baseUrl/payment/bakong/generate-qr'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'amount': amount}),
    );
  }

  Future<http.Response> checkStatus(int paymentId, String token) async {
    return await client.get(
      Uri.parse('$baseUrl/payment/bakong/status/$paymentId'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
