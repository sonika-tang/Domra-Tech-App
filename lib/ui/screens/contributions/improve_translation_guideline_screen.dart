import 'package:flutter/material.dart';

import 'widgets/guideline_step_widget.dart';
import 'submit_correction_screen.dart';

class ImproveTranslationGuidelineScreen extends StatelessWidget {
  const ImproveTranslationGuidelineScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Improve Translation', style: TextStyle(color: Colors.white)),
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
              bottom: 100, // Space for the bottom button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GuidelineStepWidget(
                  stepTitle: 'STEP01 - Search the Translation',
                  description:
                      'Navigate to the home page and search your preferred word.',
                  imagePath: 'assets/imgs/request2.png',
                ),
                GuidelineStepWidget(
                  stepTitle: 'STEP02 - Suggest a Better Version',
                  description:
                      'Enter your corrected term or improved definition with a short explanation.',
                  imagePath: 'assets/imgs/request2.png',
                ),
                GuidelineStepWidget(
                  stepTitle: 'STEP03 - Submit Your Improvement',
                  description:
                      'Tap Submit Update and our team will verify and apply the improvement.',
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
                    builder: (context) => const SubmitCorrectionScreen(),
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
              child: const Text(
                'Improve Now', 
                style: TextStyle(
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
