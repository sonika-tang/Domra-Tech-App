class PaymentModel {
  final int? paymentId;
  final String? qrString;
  final String? deepLink;
  final String? md5Hash;
  final String status;
  final double amount;
  final String? billNumber;

  PaymentModel({
    this.paymentId,
    this.qrString,
    this.deepLink,
    this.md5Hash,
    required this.status,
    required this.amount,
    this.billNumber,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    // 1. Handle nested 'data' key or 'result' key common in Node.js
    final source = json['data'] ?? json['result'] ?? json;

    return PaymentModel(
      // 2. Safely parse ID (In case Node sends it as a String or BigInt)
      paymentId: source['paymentId'] is int
          ? source['paymentId']
          : int.tryParse(source['paymentId'].toString()),

      qrString: source['qrString']?.toString(),
      deepLink: source['deepLink']?.toString(),
      md5Hash: source['md5Hash']?.toString(),
      status: source['status']?.toString() ?? 'pending',

      // 3. Your current amount logic is great, keep it!
      amount: (source['amount'] is num)
          ? source['amount'].toDouble()
          : double.tryParse(source['amount']?.toString() ?? '0') ?? 0.0,

      billNumber: source['externalTransactionId']?.toString(),
    );
  }
  // Method to convert Dart Object back to JSON (useful for local storage/logs)
  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'qrString': qrString,
      'deepLink': deepLink,
      'md5Hash': md5Hash,
      'status': status,
      'amount': amount,
      'externalTransactionId': billNumber,
    };
  }
}