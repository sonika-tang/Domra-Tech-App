import 'package:flutter/material.dart';

class HistoryAllScreen extends StatelessWidget {
  const HistoryAllScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('All Contributions')),
    body: const Center(child: Text('WordRequest + CorrectionRequest')),
  );
}
