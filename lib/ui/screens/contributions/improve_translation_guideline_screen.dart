import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'widgets/guideline_step_widget.dart';
import 'package:domra_tech/routes/navigation_helper.dart';

class ImproveTranslationGuidelineScreen extends StatelessWidget {
  const ImproveTranslationGuidelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.improveTranslation, style: TextStyle(color: Colors.white)),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 32,
              bottom: 100, // Space for the bottom button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GuidelineStepWidget(stepTitle: loc.g2Step1, description: loc.g2Step1Sub, imagePath: 'assets/imgs/request2.png'),
                GuidelineStepWidget(stepTitle: loc.g2Step2, description: loc.g2Step2Sub, imagePath: 'assets/imgs/request2.png'),
                GuidelineStepWidget(stepTitle: loc.g2Step3, description: loc.g2Step3Sub, imagePath: 'assets/imgs/request2.png', isLast: true),
              ],
            ),
          ),

          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: PrimaryButton(
              label: loc.improveNow,
              onPressed: () {
                context.goToHome(clearStack: true);
              },
            ),
          ),
        ],
      ),
    );
  }
}
