import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/navigation_helper.dart';
import '../../../state/models/user_state.dart';
import '../../../state/provider/auth_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final PageController _pageController = PageController();
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  int _currentPage = 0;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          t.changePassword,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            if (_currentPage == 1) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              setState(() => _currentPage = 0);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Consumer2<UserNotifier, AuthProvider>(
        builder: (context, userProvider, authProvider, child) {
          final userState = userProvider.state;

          return PageView(
            controller: _pageController,
            physics:
                const NeverScrollableScrollPhysics(), // Only move via buttons
            children: [
              _buildStep1(context, theme, colorScheme),
              _buildStep2(
                context,
                theme,
                colorScheme,
                userState,
                userProvider,
                authProvider,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStep1(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final t = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomField(
            label: t.currentPassword,
            hint: t.enterCurrentPass,
            controller: currentPasswordController,
            obscureText: _obscureCurrent,
            toggleObscure: () =>
                setState(() => _obscureCurrent = !_obscureCurrent),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (currentPasswordController.text.isEmpty) {
                  _showError(context, t.pleaseEnterCurrentPassword);
                  return;
                }
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                setState(() => _currentPage = 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                t.next,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    UserState userState,
    UserNotifier userProvider,
    AuthProvider authProvider,
  ) {
    final t = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomField(
            label: t.newPassword,
            hint: t.enterNewPasswordHint,
            controller: newPasswordController,
            obscureText: _obscureNew,
            toggleObscure: () => setState(() => _obscureNew = !_obscureNew),
          ),
          const SizedBox(height: 24),
          _buildCustomField(
            label: t.confirmPasswordHint,
            hint: t.enterConfirmPasswordHint,
            controller: confirmPasswordController,
            obscureText: _obscureConfirm,
            toggleObscure: () =>
                setState(() => _obscureConfirm = !_obscureConfirm),
          ),
          const SizedBox(height: 16),
          if (userState.error != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                userState.error!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: userState.isLoading
                  ? null
                  : () => _handleChangePassword(
                      context,
                      userProvider,
                      authProvider,
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: userState.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      t.finish,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = true,
    VoidCallback? toggleObscure,
  }) {
    const Color inputBackgroundColor = Color(0xFFEBEFF7);
    const Color labelColor = Color(0xFF9E9E9E);
    const Color hintColor = Color(0xFFBDBDBD);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: labelColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: hintColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: inputBackgroundColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: toggleObscure != null
                ? IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF9E9E9E),
                      size: 20,
                    ),
                    onPressed: toggleObscure,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleChangePassword(
    BuildContext context,
    UserNotifier userProvider,
    AuthProvider authProvider,
  ) async {
    if (newPasswordController.text.isEmpty) {
      _showError(context, 'Please enter new password');
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      _showError(context, 'Please confirm your password');
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      _showError(context, 'Passwords do not match');
      return;
    }
    if (newPasswordController.text.length < 6) {
      _showError(context, 'Password must be at least 6 characters');
      return;
    }

    final token = authProvider.jwt;
    if (token == null) {
      _showError(context, 'Session expired. Please log in again.');
      return;
    }

    final success = await userProvider.changePassword(
      currentPasswordController.text,
      newPasswordController.text,
      token,
    );

    if (success && context.mounted) {
      final t = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.passwordChangedSuccessfully),
          backgroundColor: AppColors.success,
        ),
      );
      context.goBack();
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
