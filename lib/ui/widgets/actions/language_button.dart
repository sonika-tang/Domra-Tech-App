import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final String language;
  final String imagePath;
  final VoidCallback onSelected;
  final bool isSelected;

  const LanguageButton({
    super.key,
    required this.language,
    required this.imagePath,
    required this.onSelected,
    this.isSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: colorScheme.secondary) : null,
        ),
        child: Row(
          children: [
            // Flag
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                imagePath,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),

            const Spacer(),
            // Language text
            Text(
              language,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const Spacer(),
            // Selection icon
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
