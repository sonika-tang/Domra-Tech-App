import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
import '../../../state/models/user_state.dart';
import '../../../state/provider/auth_provider.dart';
import '../../widgets/actions/primary_button.dart';
import '../../widgets/inputs/text_field.dart';

class SignupScreen1 extends StatefulWidget {
  const SignupScreen1({super.key});

  @override
  State<SignupScreen1> createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          // Logo area – fills available space above the form
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/imgs/Domra_Tech-logo-Transparent.png",
                height: size.height * 0.28,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Form panel pinned to bottom
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.s24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      loc.signUp,
                      style: AppTextStyle.heading1.copyWith(
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Email field with format validation
                    InputTextField(
                      title: loc.email,
                      text: loc.enterEmail,
                      controller: _emailController,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return loc.emailRequired;
                        }
                        if (!_emailRegex.hasMatch(v.trim())) {
                          return loc.invalidEmailFormat;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Next button
                    PrimaryButton(
                      label: loc.next,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.signup2,
                            arguments: {"email": _emailController.text.trim()},
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.background)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            loc.continueWith,
                            style: AppTextStyle.body2.copyWith(
                              color: AppColors.background,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.background)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s16),

                    // Social login buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/imgs/google.png",
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
                          iconSize: 40,
                          onPressed: () async {
                            try {
                              final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false,
                              );
                              final jwt = await authProvider.signInWithGoogle();
                              if (jwt != null) {
                                await context
                                    .read<UserNotifier>()
                                    .fetchUserProfile(jwt);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Google signup successful"),
                                    ),
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.home,
                                  );
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Google error: $e")),
                                );
                              }
                            }
                          },
                        ),
                        const SizedBox(width: 24),
                        IconButton(
                          icon: const Icon(Icons.facebook),
                          iconSize: 40,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Facebook signup not yet implemented"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Already have account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loc.haveAccount,
                          style: AppTextStyle.small.copyWith(
                            color: AppColors.background,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          },
                          child: Text(
                            loc.login,
                            style: AppTextStyle.small.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
