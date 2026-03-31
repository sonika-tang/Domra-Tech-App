import 'package:flutter/material.dart';

class ContributionSuccessScreen extends StatelessWidget {
  const ContributionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Light green circle background
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F9F0), // Very light green
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Color(
                      0xFF4CB050,
                    ), // Standard material green matching design
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title Text
              const Text(
                'Request submitted successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4CB050),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle Text
              const Text(
                'Our team will review your\ncontribution soon.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 48),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Let's use pushReplacement or popUntil to avoid weird back stacks
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   '/history-all',
                        //   (route) => route.settings.name == '/home' || route.isFirst
                        // );
                        Navigator.pushReplacementNamed(context, '/history-all');
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   '/history-all',
                        //   ModalRoute.withName('/profile'),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B5998),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'View History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEDB151),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Return Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
