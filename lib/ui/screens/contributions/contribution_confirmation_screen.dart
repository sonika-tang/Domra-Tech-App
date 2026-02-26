import 'package:flutter/material.dart';

class ContributionConfirmationScreen extends StatelessWidget {
  final String type;
  final int? wordRequestId;
  final int? correctionId;

  const ContributionConfirmationScreen({
    super.key,
    required this.type,
    this.wordRequestId,
    this.correctionId,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Confirmation')),
    body: Center(child: Text('$type Confirmed')),
  );
}
