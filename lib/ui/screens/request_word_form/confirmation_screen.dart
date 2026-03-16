import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/ui/screens/main_shell.dart';
import 'package:domra_tech/ui/screens/profile/history_all_screen.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/ui/widgets/actions/secondary_button.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon with circular background
            Container(
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F8F1), // Very light green
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF4CAF50), // Success green
                size: 80,
              ),
            ),
            const SizedBox(height: 32),

            // Success Message
            Text(
              "Request submitted successfully!",
              textAlign: TextAlign.center,
              style: AppTextStyle.heading3.copyWith(color: const Color(0xFF4CAF50), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Subtitle text
            Text(
              "Our team will review your\ncontribution soon.",
              textAlign: TextAlign.center,
              style: AppTextStyle.body1.copyWith(color: Colors.grey[600], height: 1.5),
            ),
            const SizedBox(height: 48),

            // Action Buttons
            Row(
              children: [
                // View History Outlined Button
                Expanded(
                  child: SecondaryButton(
                    label: loc.viewHistory,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryAllScreen()));
                    },
                  ),
                ),
                // Return Home Primary Button
                Expanded(
                  child: PrimaryButton(
                    label: loc.returnHome,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainShell()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
