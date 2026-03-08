import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/inputs/password_field.dart';

/// Three-field password change form: current password, new password, confirm.
class PasswordForm extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const PasswordForm({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputPasswordField(
          title: t.currentPassword,
          hint: t.enterCurrentPass,
          controller: currentPasswordController,
        ),
        const SizedBox(height: 20),
        InputPasswordField(
          title: t.newPass,
          hint: t.enterNewPass,
          controller: newPasswordController,
        ),
        const SizedBox(height: 20),
        InputPasswordField(
          title: t.confirmPassword,
          hint: t.enterConfirmPassword,
          controller: confirmPasswordController,
        ),
      ],
    );
  }
}
