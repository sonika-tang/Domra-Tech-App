import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/actions/primary_button.dart';
import 'widgets/onboarding_content.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: "Contribute To Khmer Technical Vocabulary",
      subtitle:
          "Add new terms or request corrections to improve the community.",
      illustration: Image.asset("assets/imgs/request2.png", height: 200),
      currentPage: 3,

      bottomWidget: PrimaryButton(
        label: "Get Start",
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.welcome);
        },
      ),
    );
  }
}
