import 'package:flutter/material.dart';
class StyledDropdown extends StatelessWidget {
  final String title;
  final String hint;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const StyledDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.bodyMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((g) => DropdownMenuItem(value: g, child: Text(g)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodySmall?.copyWith(color: Colors.white70),
            filled: true,
            fillColor: colorTheme.secondary,
            enabledBorder: _outlineBorder(colorTheme.secondary),
            focusedBorder: _outlineBorder(colorTheme.secondary),
          ),
          style: const TextStyle(color: Colors.white70), // dropdown text white
          dropdownColor: colorTheme.secondary, // dropdown menu background
        ),
      ],
    );
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}
