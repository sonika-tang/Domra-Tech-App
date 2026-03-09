import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/ui/widgets/displays/contribute_term_card.dart';
import 'package:flutter/material.dart';

class ContributionGuidelineScreen extends StatelessWidget {
  const ContributionGuidelineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.navContribute, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContributeTermCard(
                title: loc.wordRequest,
                imagePath: "assets/imgs/contribute-term.jpg",
                onView: () {},
                onRequestNow: () {},
                primaryButtonLabel: loc.requestNow,
                secondaryButtonLabel: loc.guideline,
              ),
              const SizedBox(height: AppSpacing.s24),
              ContributeTermCard(
                title: loc.wordRequest,
                imagePath: "assets/imgs/contribute-term.jpg",
                onView: () {},
                onRequestNow: () {},
                primaryButtonLabel: loc.requestNow,
                secondaryButtonLabel: loc.guideline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
