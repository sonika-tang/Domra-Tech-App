import 'package:flutter/material.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Language')),
    body: const Center(child: Text('Change Language')),
  );
}
