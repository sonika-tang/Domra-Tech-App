class PaymentModel {
  final int? paymentId;
  final String? qrString;
  final String? md5Hash;
  final String status;
  final double amount;
  final String? billNumber;

  PaymentModel({
    this.paymentId,
    this.qrString,
    this.md5Hash,
    required this.status,
    required this.amount,
    this.billNumber,
  });

  // Factory to convert Node.js JSON to Dart Object
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    // Check if data is nested inside a 'data' key (common in Node responses)
    final source = json['data'] ?? json;

    return PaymentModel(
      paymentId: source['paymentId'],
      qrString: source['qrString'],
      md5Hash: source['md5Hash'],
      status: source['status'] ?? 'pending',
      // Ensure amount is double regardless if Node sends it as int or string
      amount: (source['amount'] is num) 
          ? source['amount'].toDouble() 
          : double.tryParse(source['amount'].toString()) ?? 0.0,
      billNumber: source['externalTransactionId'],
    );
  }

  // Method to convert Dart Object back to JSON (useful for local storage/logs)
  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'qrString': qrString,
      'md5Hash': md5Hash,
      'status': status,
      'amount': amount,
      'externalTransactionId': billNumber,
    };
  }
}