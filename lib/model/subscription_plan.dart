class SubscriptionPlan {
  final String id;
  final String title;
  final String priceLabel;
  final double priceAmount;

  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.priceLabel,
    required this.priceAmount,
  });

  // useful for Node.js backend connection later
  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      priceLabel: json['priceLabel'] ?? '',
      priceAmount: (json['priceAmount'] ?? 0).toDouble(),
    );
  }
}
