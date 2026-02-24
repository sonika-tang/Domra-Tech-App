import 'package:flutter/material.dart';

class SubscriptionSuccessScreen extends StatelessWidget {
  final String planName;
  const SubscriptionSuccessScreen({super.key, required this.planName});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Success')),
    body: Center(child: Text('Welcome to $planName')),
  );
}
