import 'package:domra_tech/model/subscription_plan.dart';

final List<SubscriptionPlan> mockPlans = [
  SubscriptionPlan(
    id: 'yearly_01',
    title: 'Yearly',
    priceLabel: '\$11.50/yr',
    priceAmount: 11.50,
  ),
  SubscriptionPlan(
    id: 'monthly_01',
    title: 'Monthly',
    priceLabel: '\$0.99/m',
    priceAmount: 0.99,
  ),
  SubscriptionPlan(
    id: 'weekly_01',
    title: 'Weekly',
    priceLabel: '\$0.25/w',
    priceAmount: 0.25,
  ),
];
