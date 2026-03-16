import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BakongQrView extends StatelessWidget {
  final String? qrData;
  final bool isLoading;
  final String statusText;

  const BakongQrView({
    super.key,
    this.qrData,
    required this.isLoading,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "KHQR",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.red, // Standard KHQR color
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.tertiaryContainer),
              borderRadius: BorderRadius.circular(16),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : QrImageView(
                    data: qrData ?? "",
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
          ),
          const SizedBox(height: 20),
          Text(
            statusText,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
