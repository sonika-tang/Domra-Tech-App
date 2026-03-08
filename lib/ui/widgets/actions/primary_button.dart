import 'package:flutter/material.dart';

//This primary button use accross all screen (eventhough the color is secondary color but it have primary action)
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          disabledBackgroundColor: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
          elevation: 0,
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
