import 'package:domra_tech/state/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            "assets/imgs/Domra_Tech-logo-Transparent.png",
            height: 260,
          ),
          const Spacer(),
          LoginForm(
            errorMessage: _errorMessage,
            onInputChanged: () {
              if (_errorMessage != null) {
                setState(() {
                  _errorMessage = null;
                });
              }
            },
            onSubmit: (email, password) async {
              try {
                await authProvider.loginWithFirebase(email, password);
                setState(() {
                  _errorMessage = null;
                });
                // Navigator.pushReplacementNamed(context, "/home");

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Login successful")));
              } catch (e) {
                setState(() {
                  _errorMessage = "Invalid credentials"; // show inline
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
