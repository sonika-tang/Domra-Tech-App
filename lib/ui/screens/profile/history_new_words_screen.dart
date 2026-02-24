import 'package:flutter/material.dart';

class HistoryNewWordsScreen extends StatelessWidget {
  const HistoryNewWordsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New Words')),
    body: const Center(child: Text('WordRequest List')),
  );
}
