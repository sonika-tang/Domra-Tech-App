import 'package:domra_tech/ui/screens/subscription/payment_screen.dart';
import 'package:domra_tech/ui/screens/subscription/widgets/plan_package.dart';
import 'package:domra_tech/ui/screens/subscription/widgets/pricing_card.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:domra_tech/data/subscription_plan_data.dart';

class NewSubscriptionScreen extends StatefulWidget {
  const NewSubscriptionScreen({super.key});

  @override
  State<NewSubscriptionScreen> createState() => _NewSubscriptionScreenState();
}

class _NewSubscriptionScreenState extends State<NewSubscriptionScreen> {
  String selectedPlanId = 'weekly_01';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Subscription'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: Colors.white, 
        ),
      ),
      // LayoutBuilder detects the available screen height
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              // Forces the content to be at least as tall as the screen
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                // IntrinsicHeight allows Spacer() to work inside a ScrollView
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Pricing",
                        style: textTheme.headlineLarge?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Get unlimited access to all features",
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

                      // This Spacer now works correctly thanks to IntrinsicHeight
                      const Spacer(),
                      SizedBox(height: 24,),

                      const PlanPackageBenefits(),

                      const SizedBox(height: 40),

                      PrimaryButton(
                        label: "Next",
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
    const String token = "YOUR_SESSION_TOKEN";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BakongPaymentScreen(amount: amount, token: token),
      ),
    );
  }
}
