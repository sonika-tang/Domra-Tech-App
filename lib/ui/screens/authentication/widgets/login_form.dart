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
  void initState() {
    super.initState();
    _emailController.addListener(_onInput);
    _passwordController.addListener(_onInput);
  }

  void _onInput() => widget.onInputChanged?.call();

  // Simple email regex
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
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
                  if (value == null || value.trim().isEmpty) {
                    return loc.emailRequired;
                  }
                  if (!_emailRegex.hasMatch(value.trim())) {
                    return loc.invalidEmailFormat;
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.s16),

              // Password field
              InputPasswordField(
                title: loc.password,
                hint: loc.enterPassword,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return loc.passwordRequired;
                  }
                  if (value.length < 6) {
                    return loc.passwordTooShort;
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.s16),

              // Remember me + Forgot password
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

              // Server-side error message
              if (widget.errorMessage != null) ...[
                const SizedBox(height: AppSpacing.s8),
                Text(
                  widget.errorMessage!,
                  style: AppTextStyle.small.copyWith(
                    color: Colors.redAccent.shade100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: AppSpacing.s16),

              // Login button
              PrimaryButton(
                label: loc.login,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    widget.onSubmit(email, password);
                  }
                },
              ),

              const SizedBox(height: AppSpacing.s16),

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
