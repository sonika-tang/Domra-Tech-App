import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:domra_tech/model/payment.dart';
import 'package:domra_tech/service/payment_service.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/ui/screens/subscription/widgets/bakong_qr_display.dart';

class BakongPaymentScreen extends StatefulWidget {
  final double amount;
  final String token;

  const BakongPaymentScreen({
    super.key,
    required this.amount,
    required this.token,
  });

  @override
  State<BakongPaymentScreen> createState() => _BakongPaymentScreenState();
}

class _BakongPaymentScreenState extends State<BakongPaymentScreen> {
  late PaymentService _paymentService;
  PaymentModel? _paymentData;
  bool _isLoading = true;
  bool _isSuccess = false;
  String _selectedCurrency = "USD";
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService(http.Client());
    //_fetchQR();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  // Future<void> _fetchQR() async {
  //   setState(() => _isLoading = true);
  //   try {
  //     final response = await _paymentService.generateBakongQR(
  //       widget.amount,
  //       widget.token,
  //     );
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _paymentData = PaymentModel.fromJson(jsonDecode(response.body));
  //         _isLoading = false;
  //       });
  //       if (_paymentData?.paymentId != null)
  //         _startPolling(_paymentData!.paymentId!);
  //     }
  //   } catch (e) {
  //     setState(() => _isLoading = false);
  //   }
  // }

  // void _startPolling(int id) {
  //   _pollingTimer?.cancel();
  //   _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
  //     final response = await _paymentService.checkStatus(id, widget.token);
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['data']['status'] == 'success') {
  //         timer.cancel();
  //         setState(() => _isSuccess = true);
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Background inherits from your AppTheme, matching NewSubscriptionScreen
      appBar: AppBar(
        title: const Text('New Subscription'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: textTheme.headlineSmall?.copyWith(color: Colors.white),
        backgroundColor: colorScheme.primary, // Keep the brand blue header
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Small Switcher positioned near the price
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _selectedCurrency == "USD"
                      ? "\$ ${widget.amount.toStringAsFixed(2)}"
                      : "${(widget.amount * 4100).toStringAsFixed(0)} KHR",
                  style: textTheme.displaySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                _buildSmallCurrencySwitcher(colorScheme),
              ],
            ),

            const SizedBox(height: 40),

            BakongQrView(
              qrData: _paymentData?.qrString,
              isLoading: _isLoading,
              statusText: _isSuccess ? "Success!" : "Scan with any Bank App",
            ),

            const Spacer(),

            // Logic: DeepLink (if pending) or Done (if success)
            PrimaryButton(
              label: _isSuccess ? "Done" : "Pay in Bakong App",
              onPressed: () {
                if (_isSuccess) {
                  Navigator.pop(context);
                } else if (_paymentData?.qrString != null) {
                  _paymentService.launchBakongApp(_paymentData!.qrString!);
                }
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCurrencySwitcher(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCurrency,
          isDense: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: colorScheme.primary,
            size: 16,
          ),
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          dropdownColor: Colors.white,
          items: [
            "USD",
            "KHR",
          ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (val) {
            if (val != null && val != _selectedCurrency) {
              setState(() => _selectedCurrency = val);
              //_fetchQR();
            }
          },
        ),
      ),
    );
  }
}
