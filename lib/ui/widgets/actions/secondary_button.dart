import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const SecondaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: colorScheme.secondary, //outline color
            width: 1, //border stroke
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
          foregroundColor: colorScheme.secondary, //text color
        ),
        child: Text(label),
      ),
    );
  }
}
