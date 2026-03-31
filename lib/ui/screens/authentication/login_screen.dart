import 'package:domra_tech/state/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/app_routes.dart';
import '../../../state/models/user_state.dart';
import 'widgets/login_form.dart';

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Allow the body to extend behind the system UI so the logo area
      // fills the full screen height.
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Column(
          children: [
            // ── Logo area – expands to fill available space above the form ──
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Image.asset(
                    "assets/imgs/Domra_Tech-logo-Transparent.png",
                    height: size.height * 0.28,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            SafeArea(
              top: false,
              child: Stack(
                children: [
                  LoginForm(
                    errorMessage: _errorMessage,
                    onInputChanged: () {
                      if (_errorMessage != null) {
                        setState(() => _errorMessage = null);
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
                          debugPrint("Backend JWT stored: ${authProvider.jwt}");
                          await userNotifier
                              .fetchUserProfile(authProvider.jwt!);

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Login successful")),
                            );
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.home);
                          }
                        }
                      } catch (e) {
                        debugPrint("Login error: $e");
                        setState(() {
                          _errorMessage = "Invalid credentials";
                        });
                      } finally {
                        if (mounted) setState(() => _loading = false);
                      }
                    },
                  ),
                  if (_loading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black26,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}