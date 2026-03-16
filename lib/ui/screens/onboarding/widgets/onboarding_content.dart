import 'package:flutter/material.dart';
import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';

import 'page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget illustration;
  final int currentPage;
  final VoidCallback? onSkip;
  final VoidCallback? onNext;
  final Widget? bottomWidget;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustration,
    required this.currentPage,
    this.onSkip,
    this.onNext,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.s48),
              Text(
                title,
                style: AppTextStyle.largeTitle.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s16),
              Text(
                subtitle,
                style: AppTextStyle.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 100),
              illustration,

              const Spacer(),

              // Page indicator
              PageIndicator(totalPages: 3, currentPage: currentPage),

              const SizedBox(height: AppSpacing.s24),

              // Either custom bottom widget OR default Skip/Next row
              bottomWidget ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: onSkip,
                        child: Text(
                          "Skip",
                          style: AppTextStyle.body1.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: onNext,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

              const SizedBox(height: AppSpacing.s48),
            ],
          ),
        ),
      ),
    );
  }
}
