import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
import '../../../state/models/user_state.dart';
import '../../../state/provider/auth_provider.dart';
import '../../widgets/actions/primary_button.dart';
import '../../widgets/inputs/password_field.dart';

class SignupScreen3 extends StatefulWidget {
  final Map<String, dynamic> signupData;
  const SignupScreen3({super.key, required this.signupData});

  @override
  State<SignupScreen3> createState() => _SignupScreen3State();
}

class _SignupScreen3State extends State<SignupScreen3> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool agreeTerms = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          // Logo area
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
                    Text(
                      loc.setPassword,
                      style: AppTextStyle.heading1.copyWith(
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Password – required + min 6 chars
                    InputPasswordField(
                      title: loc.password,
                      hint: loc.enterPassword,
                      controller: _passwordController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return loc.passwordRequired;
                        if (v.length < 6) return loc.passwordTooShort;
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s16),

                    // Confirm password – must match
                    InputPasswordField(
                      title: loc.confirmPassword,
                      hint: loc.enterPassword,
                      controller: _confirmController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return loc.passwordRequired;
                        if (v != _passwordController.text) {
                          return loc.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s16),

                    // Agree to Terms checkbox + clickable link
                    Row(
                      children: [
                        Checkbox(
                          value: agreeTerms,
                          onChanged: (v) =>
                              setState(() => agreeTerms = v ?? false),
                          activeColor: AppColors.secondary,
                          checkColor: Colors.white,
                          side:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                        Text(
                          '${loc.agree} ',
                          style: AppTextStyle.small.copyWith(
                            color: AppColors.background,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.termsAndConditions),
                          child: Text(
                            loc.termsAndConditionsLink,
                            style: AppTextStyle.small.copyWith(
                              color: AppColors.secondary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    PrimaryButton(
                      label: loc.finish,
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && agreeTerms) {
                          final userData = {
                            ...widget.signupData,
                            "password": _passwordController.text.trim(),
                          };

                          try {
                            final authProvider = Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            );
                            final fbUser =
                                await authProvider.signupWithFirebase(
                              email: userData["email"],
                              password: userData["password"],
                              firstName: userData["firstName"],
                              lastName: userData["lastName"],
                              gender: userData["gender"],
                              dob: userData["dob"],
                            );

                            if (fbUser != null && authProvider.jwt != null) {
                              await context.read<UserNotifier>().fetchUserProfile(
                                    authProvider.jwt!,
                                  );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Signup successful"),
                                  ),
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.home,
                                );
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Signup failed")),
                                );
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Exception: $e")),
                              );
                            }
                          }
                        } else if (!agreeTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "${loc.agreeToTerms} ${loc.termsAndConditionsLink}"),
                            ),
                          );
                        }
                      },
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
