import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/ui/widgets/inputs/password_field.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/state/provider/auth_provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token; // passed from deep link or route
  const ResetPasswordScreen({super.key, required this.token, required String email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final loc = AppLocalizations.of(context)!;
    if (_formKey.currentState!.validate()) {
      final newPassword = _newPasswordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();
      final authProvider = context.read<AuthProvider>();

      final success = await authProvider.resetPassword(
        widget.token,
        newPassword,
        confirmPassword,
      );

      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('loc.passwordResetSuccess')));
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('loc.passwordResetFailed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  loc.setPassword,
                  style: AppTextStyle.heading1.copyWith(
                    color: AppColors.background,
                  ),
                ),
                const SizedBox(height: 24),
                InputPasswordField(
                  title: loc.newPassword,
                  hint: loc.enterNewPass,
                  controller: _newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return loc.passwordRequired;
                    if (value.length < 6) return loc.passwordTooShort;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InputPasswordField(
                  title: loc.confirmPassword,
                  hint: loc.enterConfirmPassword,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return loc.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: loc.finish,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newPassword = _newPasswordController.text.trim();
                      final confirmPassword = _confirmPasswordController.text
                          .trim();
                      final success = await context
                          .read<AuthProvider>()
                          .resetPassword(
                            widget.token,
                            newPassword,
                            confirmPassword,
                          );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(loc.passwordChangedSuccessfully),
                          ),
                        );
                        Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('loc.passwordResetFailed')),
                        );
                      }
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}