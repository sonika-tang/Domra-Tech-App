import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import 'widgets/onboarding_content.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});
  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: "Welcome to Domra",
      subtitle: "Your trilingual technical dictionary for Cambodia",
      illustration: Image.asset("assets/imgs/contribute-term.jpg", height: 200),
      currentPage: 1,
      onSkip: () => Navigator.pushReplacementNamed(context, AppRoutes.welcome),
      onNext: () => Navigator.pushNamed(context, AppRoutes.onboarding2),
    );
  }
}
