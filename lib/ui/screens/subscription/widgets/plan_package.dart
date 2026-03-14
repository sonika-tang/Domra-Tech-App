import 'package:flutter/material.dart';

class PlanPackageBenefits extends StatelessWidget {
  const PlanPackageBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<String> globalFeatures = [
      'Get the offline Mode',
      'Use app without Ads',
      'Get unlimited access to all features',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            "What's included",
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...globalFeatures.map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(Icons.check, color: colorScheme.primary, size: 20),
                  const SizedBox(width: 12),
                  Text(feature, style: textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
