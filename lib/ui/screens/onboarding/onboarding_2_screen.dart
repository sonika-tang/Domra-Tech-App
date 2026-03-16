import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import 'widgets/onboarding_content.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: "Find Accurate Technical Terms Fast",
      subtitle: "Search across Khmer - English - French with ease.",
      illustration: Image.asset("assets/imgs/loginPic2.png", height: 200),
      currentPage: 2,
      onSkip: () => Navigator.pushReplacementNamed(context, AppRoutes.welcome),
      onNext: () => Navigator.pushNamed(context, AppRoutes.onboarding3),
    );
  }
}
