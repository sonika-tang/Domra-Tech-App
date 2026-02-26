import 'package:flutter/material.dart';

class InputPasswordField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const InputPasswordField({super.key, required this.title, required this.hint, this.controller, this.validator});

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  // Use ValueNotifier for toggle visibility without rebuild the widget
  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _isObscured.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSecondary)),
        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _isObscured,
          builder: (context, bool obscured, child) {
            return TextFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              validator: widget.validator,
              obscureText: obscured,
              // Critical for security and keyboard behavior
              keyboardType: TextInputType.visiblePassword,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onTertiaryContainer),
                filled: true,
                fillColor: Colors.white,
                // Keep suffixIcon present but toggle visibility to prevent layout jumping
                suffixIcon: _buildSuffixIcon(theme, obscured),
                enabledBorder: _outlineBorder(Colors.white),
                focusedBorder: _outlineBorder(theme.colorScheme.secondary),
                errorBorder: _outlineBorder(theme.colorScheme.error),
                focusedErrorBorder: _outlineBorder(theme.colorScheme.error),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon(ThemeData theme, bool obscured) {
    // We only show the icon if the field is focused OR has text
    return ListenableBuilder(
      listenable: _focusNode,
      builder: (context, child) {
        if (!_focusNode.hasFocus) return const SizedBox.shrink();

        return IconButton(
          onPressed: () => _isObscured.value = !_isObscured.value,
          icon: Icon(obscured ? Icons.visibility_off : Icons.visibility, color: theme.colorScheme.secondary),
        );
      },
    );
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}
