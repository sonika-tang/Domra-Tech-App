import 'package:flutter/foundation.dart';
import '../../model/payment.dart';

/// Payment state model
/// Holds all payment and subscription-related state
class PaymentState {
  final PaymentModel? currentPayment;
  final String? paymentStatus;
  final bool isProcessing;
  final String? error;
  final List<String> availablePlans;
  final String? selectedPlan;
  final DateTime? lastUpdated;

  const PaymentState({
    this.currentPayment,
    this.paymentStatus,
    this.isProcessing = false,
    this.error,
    this.availablePlans = const ['Basic', 'Standard', 'Premium'],
    this.selectedPlan,
    this.lastUpdated,
  });

  /// Create a copy with modified fields
  PaymentState copyWith({
    PaymentModel? currentPayment,
    String? paymentStatus,
    bool? isProcessing,
    String? error,
    List<String>? availablePlans,
    String? selectedPlan,
    DateTime? lastUpdated,
  }) {
    return PaymentState(
      currentPayment: currentPayment ?? this.currentPayment,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error ?? this.error,
      availablePlans: availablePlans ?? this.availablePlans,
      selectedPlan: selectedPlan ?? this.selectedPlan,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Clear error message
  PaymentState clearError() => copyWith(error: null);

  /// Set processing state
  PaymentState withProcessing() => copyWith(isProcessing: true, error: null);

  /// Check if payment is completed
  bool get isPaymentCompleted => paymentStatus == 'completed';

  /// Check if payment is pending
  bool get isPaymentPending => paymentStatus == 'pending';
}

/// Payment state notifier
/// Manages all payment-related operations
class PaymentNotifier extends ChangeNotifier {
  PaymentState _state = const PaymentState();

  PaymentState get state => _state;
  
  PaymentModel? get updatedPayment => null;

  /// Update state and notify listeners
  void _setState(PaymentState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Generate Bakong QR code for payment
  Future<bool> generateBakongQR(double amount, String token) async {
    try {
      _setState(state.withProcessing());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      // Mock payment model with QR data
      final payment = PaymentModel(
        paymentId: 1,
        qrString:
            'https://bakongQR.example.com/qr${DateTime.now().millisecondsSinceEpoch}',
        md5Hash: 'mock_md5_hash_${DateTime.now().millisecondsSinceEpoch}',
        status: 'pending',
        amount: amount,
        billNumber: 'BILL${DateTime.now().millisecondsSinceEpoch}',
      );

      _setState(
        state.copyWith(
          currentPayment: payment,
          paymentStatus: 'pending',
          isProcessing: false,
          error: null,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isProcessing: false,
          error: 'Failed to generate QR code: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Check payment status
  Future<bool> checkPaymentStatus(int paymentId, String token) async {
    try {
      _setState(state.withProcessing());

      // Simulate API call with polling
      await Future.delayed(const Duration(milliseconds: 800));

      // // Mock successful payment
      // final updatedPayment = state.currentPayment?.copyWith(
      //   status: 'completed',
      // );

      _setState(
        state.copyWith(
          currentPayment: updatedPayment,
          paymentStatus: 'completed',
          isProcessing: false,
          error: null,
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isProcessing: false,
          error: 'Failed to check payment status: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Select a subscription plan
  void selectPlan(String planName) {
    _setState(state.copyWith(selectedPlan: planName));
  }

  /// Start payment process for selected plan
  Future<bool> initiatePayment(double amount) async {
    if (state.selectedPlan == null) {
      _setState(
        state.copyWith(error: 'Please select a subscription plan first'),
      );
      return false;
    }

    return await generateBakongQR(
      amount,
      '',
    ); // Token should come from auth state
  }

  /// Complete subscription
  Future<bool> completeSubscription() async {
    try {
      _setState(state.withProcessing());

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 600));

      _setState(
        state.copyWith(
          isProcessing: false,
          error: null,
          paymentStatus: 'completed',
          lastUpdated: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _setState(
        state.copyWith(
          isProcessing: false,
          error: 'Failed to complete subscription: ${e.toString()}',
        ),
      );
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    _setState(state.clearError());
  }

  /// Reset payment state
  void resetPaymentState() {
    _setState(const PaymentState());
  }

  /// Poll payment status (useful for checking async payments)
  Future<void> pollPaymentStatus(
    int paymentId,
    String token, {
    Duration timeout = const Duration(minutes: 5),
    int maxAttempts = 10,
  }) async {
    int attempts = 0;
    final stopwatch = Stopwatch()..start();

    while (attempts < maxAttempts && stopwatch.elapsed < timeout) {
      final success = await checkPaymentStatus(paymentId, token);

      if (success && state.isPaymentCompleted) {
        return;
      }

      attempts++;

      // Wait before next attempt
      if (attempts < maxAttempts) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    // Payment not completed within timeout
    _setState(
      state.copyWith(
        error:
            'Payment verification timeout. Please check your transaction status.',
      ),
    );
  }
}
