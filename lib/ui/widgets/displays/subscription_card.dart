import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String subscriptionType;
  final double pricing;
  final VoidCallback onSelected;
  final bool isSelected;
  const SubscriptionCard({super.key, this.isSelected = false, required this.onSelected, required this.pricing, required this.subscriptionType});

  //Get the price format
  String get priceText => "\$ ${pricing.toString()}";
  //Create enum for the subscribtion type
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? Border.all(color: Theme.of(context).colorScheme.primary) : null,
      ),
      child: Row(
        children: [
          // Selection icon
          Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked, color: Theme.of(context).colorScheme.secondary),

          const SizedBox(width: 24),

          //Text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                subscriptionType,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 5),
              Text(subscriptionType, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
            ],
          ),
        ],
      ),
    );
  }
}
