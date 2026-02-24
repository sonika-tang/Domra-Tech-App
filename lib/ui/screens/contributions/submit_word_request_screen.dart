import 'package:flutter/material.dart';

class SubmitWordRequestScreen extends StatelessWidget {
  const SubmitWordRequestScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New Word')),
    body: const Center(child: Text('Submit WordRequest')),
  );
}
