import 'package:flutter/material.dart';

class SubmitCorrectionScreen extends StatelessWidget {
  final int? wordId;
  const SubmitCorrectionScreen({super.key, this.wordId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Correct Word')),
    body: Center(child: Text('Correct word #$wordId')),
  );
}
