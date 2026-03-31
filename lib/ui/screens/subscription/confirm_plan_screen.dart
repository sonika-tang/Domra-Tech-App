import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ConfirmPlanScreen extends StatelessWidget {
  final String planId;
  final String planName;
  final String planPrice;
  final double? amount;

  const ConfirmPlanScreen({
    super.key,
    required this.planId,
    required this.planName,
    required this.planPrice,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
    appBar: AppBar(title: Text(loc.confirm)),
    body: Center(child: Text('${loc.subscriptionPlans}: $planName at $planPrice')),
  );
  }
}
