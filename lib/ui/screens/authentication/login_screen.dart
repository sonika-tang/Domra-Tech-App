import 'package:domra_tech/state/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/app_routes.dart';
import '../../../state/models/user_state.dart';
import 'widgets/login_form.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String? _errorMessage;

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       body: Column(
//         children: [
//           const Spacer(),
//           Image.asset(
//             "assets/imgs/Domra_Tech-logo-Transparent.png",
//             height: 260,
//           ),
//           const Spacer(),
//           LoginForm(
//             errorMessage: _errorMessage,
//             onInputChanged: () {
//               if (_errorMessage != null) {
//                 setState(() {
//                   _errorMessage = null;
//                 });
//               }
//             },
//             onSubmit: (email, password) async {
//               try {
//                 await authProvider.loginWithFirebase(email, password);
//                 setState(() {
//                   _errorMessage = null;
//                 });
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text("Login successful")));
//                 Navigator.pushReplacementNamed(context, AppRoutes.home);
//               } catch (e) {
//                 setState(() {
//                   _errorMessage = "Invalid credentials"; // show inline
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _errorMessage;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userNotifier = Provider.of<UserNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                "assets/imgs/Domra_Tech-logo-Transparent.png",
                height: 260,
              ),
              const SizedBox(height: 20),
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
                  setState(() => _loading = true);
                  try {
                    final user = await authProvider.loginWithFirebase(
                      email,
                      password,
                    );

                    if (user != null && authProvider.jwt != null) {
                      // Debug: print token
                      debugPrint("Backend JWT stored: ${authProvider.jwt}");

                      // Fetch profile
                      await userNotifier.fetchUserProfile(authProvider.jwt!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login successful")),
                      );
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  } catch (e) {
                    debugPrint("Login error: $e");
                    setState(() {
                      _errorMessage = "Invalid credentials";
                    });
                  } finally {
                    setState(() => _loading = false);
                  }
                },
              ),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
