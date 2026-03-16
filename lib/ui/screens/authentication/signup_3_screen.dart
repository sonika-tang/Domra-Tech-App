import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
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
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            "assets/imgs/Domra_Tech-logo-Transparent.png",
            height: 200,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(AppSpacing.s24),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    loc.setPassword,
                    style: AppTextStyle.heading1.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s24),
                  InputPasswordField(
                    title: loc.password,
                    hint: loc.enterPassword,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  InputPasswordField(
                    title: loc.confirmPassword,
                    hint: loc.enterPassword,
                    controller: _confirmController,
                    validator: (v) => v != _passwordController.text
                        ? "Passwords do not match"
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Row(
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        onChanged: (v) =>
                            setState(() => agreeTerms = v ?? false),
                      ),
                      Text('Agree Terms'),
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
                          final response = await authProvider.authService
                              .register(userData);
                          if (response.statusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Signup successful"),
                              ),
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.home,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error: ${response.body}"),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Exception: $e")),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
