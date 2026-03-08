import 'package:domra_tech/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo at top
          Image.asset(
            "assets/imgs/Domra_Tech-logo-Transparent.png",
            height: 260,
          ),
          const SizedBox(height: AppSpacing.s32),

          // Main container styled like LoginForm
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.s24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${loc.welcome} to Domra",
                    style: AppTextStyle.heading1.copyWith(
                      color: AppColors.background,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.s48),

                  // Login button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      loc.login,
                      style: AppTextStyle.body1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.s32),

                  // Sign up button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signup1);
                    },
                    child: Text(
                      loc.signUp,
                      style: AppTextStyle.body1.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Continue as guest link
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.home);
                    },
                    child: Text(
                      "Continue as Guest",
                      style: AppTextStyle.body2.copyWith(
                        color: AppColors.background,
                      ),
                    ),
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
