import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:domra_tech/model/payment.dart';
import 'package:domra_tech/service/payment_service.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/ui/screens/subscription/widgets/bakong_qr_display.dart';
import 'package:domra_tech/l10n/app_localizations.dart';

class BakongPaymentScreen extends StatefulWidget {
  final double amount;

  const BakongPaymentScreen({super.key, required this.amount});

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
  String? _jwt;

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService(http.Client());
    _loadTokenAndFetchQR();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadTokenAndFetchQR() async {
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: "jwt");

    if (jwt == null) {
      debugPrint("No JWT found, user not logged in");
      setState(() => _isLoading = false);
      return;
    }

    setState(() => _jwt = jwt);
    _fetchQR();
  }

  void _fetchQR() async {
    if (_jwt == null) return;
    setState(() => _isLoading = true);
    try {
      final payment = await _paymentService.generateBakongQR(
        widget.amount,
        _selectedCurrency,
        _jwt!,
      );
      setState(() {
        _paymentData = payment;
        _isLoading = false;
      });

      _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
        final status = await _paymentService.checkStatus(
          payment.paymentId!,
          _jwt!,
        );
        if (status == 'success') {
          setState(() {
            _isSuccess = true;
            _pollingTimer?.cancel();
          });
        }
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Error fetching QR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.subscriptionPlans),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: textTheme.headlineSmall?.copyWith(color: Colors.white),
        backgroundColor: colorScheme.primary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _selectedCurrency == "USD"
                      ? "${widget.amount.toStringAsFixed(2)} ${loc.usd}"
                      : "${(widget.amount * 4100).toStringAsFixed(0)} ${loc.khr}",
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
              statusText: _isSuccess ? loc.paymentSuccess : loc.scanQr,
            ),
            const Spacer(),
            PrimaryButton(
              label: _isSuccess ? loc.finish : loc.payWithBakong,
              onPressed: () {
                if (_isSuccess) {
                  Navigator.pop(context);
                } else if (_paymentData?.deepLink != null) {
                  _paymentService.launchBakongApp(_paymentData!.deepLink!);
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
              _fetchQR();
            }
          },
        ),
      ),
    );
  }
}
