import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import '../../service/payment_service.dart';
import '../../model/payment.dart';

class BakongTestScreen extends StatefulWidget {
  const BakongTestScreen({super.key});

  @override
  State<BakongTestScreen> createState() => _BakongTestScreenState();
}

class _BakongTestScreenState extends State<BakongTestScreen> {
  late PaymentService _paymentService;
  bool _isLoading = false;
  String? _qrData;
  String? _currentDeepLink; // Added to store the link for manual tap
  String _status = "Idle";
  Timer? _pollingTimer;

  final String _userToken = "YOUR_JWT_TOKEN";

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService(http.Client());
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  // UPDATED: Now accepts 'currency' to tell the backend which one to use
  Future<void> _startPayment(double amount, String currency) async {
    setState(() {
      _isLoading = true;
      _status = "Generating QR...";
      _qrData = null;
      _currentDeepLink = null; // Reset deep link
    });

    try {
      final PaymentModel result = await _paymentService.generateBakongQR(
        amount,
        currency, // Pass KHR or USD
        _userToken,
      );

      setState(() {
        _qrData = result.qrString;
        _currentDeepLink = result.deepLink; // Store the link
        _isLoading = false;
        _status = "Waiting for payment...";
      });

      // REMOVED: Automatic launch logic from here
      // We want the user to tap the button manually now.

      if (result.paymentId != null) {
        _startPolling(result.paymentId!);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = "Error: $e";
      });
    }
  }

  void _startPolling(int paymentId) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final status = await _paymentService.checkStatus(paymentId, _userToken);
        setState(() => _status = "Status: $status");

        if (status == 'success') {
          timer.cancel();
          _showSuccessDialog();
        }
      } catch (e) {
        debugPrint("Polling error: $e");
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Payment Received Successfully!",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _status = "Idle";
                _qrData = null;
                _currentDeepLink = null;
              });
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bakong KHQR Payment")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _status,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              if (_isLoading)
                const CircularProgressIndicator()
              else if (_qrData != null) ...[
                // Show QR Code
                QrImageView(
                  data: _qrData!,
                  version: QrVersions.auto,
                  size: 250.0,
                ),
                const SizedBox(height: 20),

                // NEW: Manual Jump Button (Only visible if deepLink exists)
                if (_currentDeepLink != null)
                  ElevatedButton.icon(
                    onPressed: () =>
                        _paymentService.launchBakongApp(_currentDeepLink!),
                    icon: const Icon(Icons.account_balance_wallet),
                    label: const Text("Open Bakong App to Pay"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
              ] else
                const Icon(
                  Icons.qr_code_scanner,
                  size: 100,
                  color: Colors.grey,
                ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _startPayment(1000.0, 'KHR'),
                    child: const Text("Pay 1000 KHR"),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _startPayment(1.0, 'USD'),
                    child: const Text("Pay \$1.00 USD"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
