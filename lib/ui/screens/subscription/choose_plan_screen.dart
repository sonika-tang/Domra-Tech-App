import 'package:flutter/material.dart';

class ChoosePlanScreen extends StatelessWidget {
  final String planId;
  const ChoosePlanScreen({super.key, required this.planId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Choose Plan')),
    body: Center(child: Text('Plan: $planId')),
  );
}
