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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Confirm')),
    body: Center(child: Text('PaymentModel: $planName at $planPrice')),
  );
}
