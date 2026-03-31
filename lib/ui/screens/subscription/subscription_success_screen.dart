import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SubscriptionSuccessScreen extends StatelessWidget {
  final String planName;
  const SubscriptionSuccessScreen({super.key, required this.planName});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.paymentSuccess)),
      body: Center(child: Text('Welcome to $planName')),
    );
  }
}
