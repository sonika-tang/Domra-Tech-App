import 'package:domra_tech/model/subscription_plan.dart';
import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PricingCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.tertiaryContainer,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Selection Indicator (Radio Style)
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_off,
              color: isSelected
                  ? colorScheme.secondary
                  : colorScheme.onTertiaryContainer,
              size: 28,
            ),
            const SizedBox(width: 16),
            // Plan Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.title,
                  style: textTheme.headlineSmall?.copyWith(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  plan.priceLabel,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
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
