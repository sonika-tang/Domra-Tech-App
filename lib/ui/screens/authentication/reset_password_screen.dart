import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Reset Password for $email')));
}
