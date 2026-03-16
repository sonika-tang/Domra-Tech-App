import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'widgets/guideline_step_widget.dart';
import 'submit_word_request_screen.dart';

class WordRequestGuidelineScreen extends StatelessWidget {
  const WordRequestGuidelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.wordRequest, style: const TextStyle(color: Colors.white)),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        backgroundColor: AppColors.primary, // Primary blue
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GuidelineStepWidget(stepTitle: loc.g1Step1, description: loc.g1Step1Sub, imagePath: 'assets/imgs/request2.png'),
                GuidelineStepWidget(stepTitle: loc.g1Step2, description: loc.g1Step2Sub, imagePath: 'assets/imgs/request2.png'),
                GuidelineStepWidget(stepTitle: loc.g1Step3, description: loc.g1Step3Sub, imagePath: 'assets/imgs/request2.png', isLast: true),
              ],
            ),
          ),
          //SubmitWordRequestScreen()
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: PrimaryButton(
              label: loc.requestNow,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SubmitWordRequestScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
