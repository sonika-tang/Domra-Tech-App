import 'package:domra_tech/l10n/app_localizations.dart';
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12),
        ),
      ),
      child: Form(
        key: _formKey,
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
            Text(
              loc.email,
              style: AppTextStyle.heading3.copyWith(
                color: AppColors.background,
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            TextFormField(
              controller: _emailController,
              onChanged: (_) {
                widget.onInputChanged?.call();
              },
              style: AppTextStyle.body1.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: loc.enterEmail,
                hintStyle: AppTextStyle.body2.copyWith(color: AppColors.gray),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.error, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.error, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.s16),

            // Password field
            Text(
              loc.password,
              style: AppTextStyle.heading3.copyWith(
                color: AppColors.background,
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              onChanged: (_) {
                widget.onInputChanged?.call();
              },
              style: AppTextStyle.body1.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: loc.enterPassword,
                hintStyle: AppTextStyle.body2.copyWith(color: AppColors.gray),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.error, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.error, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }

                return null;
              },
            ),

            if (widget.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.s16),
                child: Text(
                  widget.errorMessage!,
                  style: AppTextStyle.body2.copyWith(color: AppColors.error),
                  textAlign: TextAlign.left,
                ),
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
                      activeColor:
                          AppColors.secondary, 
                      checkColor: Colors.white, 
                      side: const BorderSide(
                        // border color
                        color: Colors.white,
                        width: 2,
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
                    Navigator.pushNamed(context, "/forgot-password");
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.s24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  // Call backend / Firebase
                  widget.onSubmit(email, password);
                }
              },
              child: Text(
                loc.login,
                style: AppTextStyle.body1.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.s24),

            // Sign up prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.dontHaveAccount,
                  style: AppTextStyle.body1.copyWith(
                    color: AppColors.background,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: Text(
                    loc.signUp,
                    style: AppTextStyle.body1.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
