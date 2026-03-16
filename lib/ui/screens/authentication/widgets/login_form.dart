import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/routes/app_routes.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/ui/widgets/inputs/password_field.dart';
import 'package:domra_tech/ui/widgets/inputs/text_field.dart';
import 'package:flutter/material.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/core/config/app_colors.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email, String password) onSubmit;
  final String? errorMessage;
  final VoidCallback? onInputChanged;
  const LoginForm({
    super.key,
    required this.onSubmit,
    this.errorMessage,
    this.onInputChanged,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Title
              Text(
                loc.login,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.s16),

              //Password filed
              InputPasswordField(
                title: loc.password,
                hint: loc.enterPassword,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.s16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                        activeColor: AppColors.secondary,
                        checkColor: Colors.white,
                        side: const BorderSide(
                          // border color
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      Text(
                        loc.rememberMe,
                        style: AppTextStyle.body2.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.forgotPassword,
                      );
                    },
                    child: Text(
                      "${loc.forgotPassword}?",
                      style: AppTextStyle.body2.copyWith(
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s16),

              // Login button
              PrimaryButton(
                label: loc.login,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();

                    // Call backend / Firebase
                    widget.onSubmit(email, password);
                  }
                },
              ),

              const SizedBox(height: AppSpacing.s24),

              // Sign up prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    loc.dontHaveAccount,
                    style: AppTextStyle.small.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.signup1,
                      );
                    },
                    child: Text(
                      loc.signUp,
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
    );
  }
}
