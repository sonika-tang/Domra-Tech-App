import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/model/subscription_plan.dart';
import 'package:domra_tech/ui/screens/subscription/payment_screen.dart';
import 'package:domra_tech/ui/screens/subscription/widgets/plan_package.dart';
import 'package:domra_tech/ui/screens/subscription/widgets/pricing_card.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _NewSubscriptionScreenState();
}

class _NewSubscriptionScreenState extends State<SubscriptionScreen> {
  String selectedPlanId = 'weekly_01';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    final List<SubscriptionPlan> mockPlans = [
      SubscriptionPlan(
        id: 'weekly_01',
        title: loc.weekly,
        priceLabel: '\$0.25/w',
        priceAmount: 0.25,
      ),
      SubscriptionPlan(
        id: 'monthly_01',
        title: loc.monthly,
        priceLabel: '\$0.99/m',
        priceAmount: 0.99,
      ),
      SubscriptionPlan(
        id: 'yearly_01',
        title: loc.yearly,
        priceLabel: '\$11.50/yr',
        priceAmount: 11.50,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.subscriptionPlans,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          loc.pricing,
                          style: textTheme.headlineLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        loc.priceDesc,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...mockPlans.map(
                        (plan) => PricingCard(
                          plan: plan,
                          isSelected: selectedPlanId == plan.id,
                          onTap: () => setState(() => selectedPlanId = plan.id),
                        ),
                      ),

                      const Spacer(),
                      const SizedBox(height: 24),
                      const PlanPackageBenefits(),
                      const SizedBox(height: 40),

                      PrimaryButton(
                        label: loc.next,
                        onPressed: () {
                          final selectedPlan = mockPlans.firstWhere(
                            (p) => p.id == selectedPlanId,
                          );
                          _handlePayment(selectedPlan.priceAmount);
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handlePayment(double amount) {
    debugPrint("Initiating Bakong payment for: \$ $amount");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BakongPaymentScreen(amount: amount),
      ),
    );
  }
}
