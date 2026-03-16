import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
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

  @override
  Widget build(BuildContext context) {
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

                  // Email field
                  InputTextField(
                    title: loc.email,
                    text: loc.enterEmail,
                    controller: _emailController,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Email required" : null,
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
                          'or ContinueWith',
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
                        icon: const Icon(Icons.g_mobiledata),
                        iconSize: 40,
                        onPressed: () async {
                          try {
                            final token = await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).signInWithGoogle();
                            if (token != null) {
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
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Google error: $e")),
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        icon: const Icon(Icons.facebook),
                        iconSize: 40,
                        onPressed: () {
                          // TODO: implement Facebook signup
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Facebook signup not yet implemented",
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
