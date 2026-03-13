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
        centerTitle: true,
        backgroundColor: const Color(0xFF3B5998), // Primary blue
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 32,
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GuidelineStepWidget(
                  stepTitle: 'STEP01 - Enter the Term',
                  description:
                      'Type the new term you want to request in English, Khmer, or French.',
                  imagePath: 'assets/imgs/request2.png',
                ),
                GuidelineStepWidget(
                  stepTitle: 'STEP02 - Add Meaning (Optional)',
                  description:
                      'Provide a short explanation or context to help reviewers understand your request.',
                  imagePath: 'assets/imgs/request2.png',
                ),
                GuidelineStepWidget(
                  stepTitle: 'STEP03 - Submit Request',
                  description:
                      'Tap Submit — your request will be reviewed and added if approved.',
                  imagePath: 'assets/imgs/request2.png',
                  isLast: true,
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubmitWordRequestScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEDB151), // Orange button
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                loc.requestNow,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
