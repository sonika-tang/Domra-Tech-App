import 'package:flutter/material.dart';

class HistoryCorrectionScreen extends StatelessWidget {
  const HistoryCorrectionScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Corrections')),
    body: const Center(child: Text('CorrectionRequest List')),
  );
}
