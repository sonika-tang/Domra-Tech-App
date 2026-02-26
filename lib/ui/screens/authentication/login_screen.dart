import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Test Firebase Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _loading = true;
                  _error = null;
                });
                try {
                  await authViewModel.loginWithFirebase(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  setState(() => _loading = false);

                  if (authViewModel.user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Login successful: ${authViewModel.user!.email}",
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  setState(() {
                    _loading = false;
                    _error = e.toString();
                  });
                }
              },
              child: const Text("Login with Firebase"),
            ),
          ],
        ),
      ),
    );
  }
}
