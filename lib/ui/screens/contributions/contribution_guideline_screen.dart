import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/ui/widgets/displays/contribute_term_card.dart';
import 'package:flutter/material.dart';

import 'improve_translation_guideline_screen.dart';
import 'submit_correction_screen.dart';
import 'submit_word_request_screen.dart';
import 'word_request_guideline_screen.dart';

class ContributionGuidelineScreen extends StatelessWidget {
  const ContributionGuidelineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.navContribute, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF3B5998),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContributeTermCard(
                title: loc.wordRequest,
                imagePath: "assets/imgs/contribute-term.jpg",
                onView: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WordRequestGuidelineScreen(),
                    ),
                  );
                },
                onRequestNow: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubmitWordRequestScreen(),
                    ),
                  );
                },
                primaryButtonLabel: loc.requestNow,
                secondaryButtonLabel: loc.guideline,
              ),
              const SizedBox(height: AppSpacing.s24),
              ContributeTermCard(
                title: 'Improve Translation', // Will need localization later
                imagePath: "assets/imgs/contribute-term.jpg", // Using same placeholder for now
                onView: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImproveTranslationGuidelineScreen(),
                    ),
                  );
                },
                onRequestNow: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubmitCorrectionScreen(),
                    ),
                  );
                },
                primaryButtonLabel: 'Improve Now',
                secondaryButtonLabel: loc.guideline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
