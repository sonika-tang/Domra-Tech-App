import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/ui/widgets/actions/secondary_button.dart';
import 'package:flutter/material.dart';

class ContributeTermCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onView;
  final VoidCallback onRequestNow;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;

  const ContributeTermCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onView,
    required this.onRequestNow,
    required this.primaryButtonLabel,
    required this.secondaryButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(16)),
            child: Image.asset(imagePath, height: 300, fit: BoxFit.contain),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(label: secondaryButtonLabel, onPressed: onView),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(label: primaryButtonLabel, onPressed: onRequestNow),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
