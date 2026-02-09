import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final String text;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const InputTextField({super.key, required this.title, required this.text, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //the title of the input  field
        Text(title, style: textTheme.bodyMedium?.copyWith(color: colorTheme.onSecondary)),
        const SizedBox(height: 8),
        //the input filed section
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: textTheme.bodySmall?.copyWith(color: colorTheme.onTertiaryContainer),

            filled: true,
            fillColor: Colors.white,

            enabledBorder: _outlineBorder(Colors.white),
            focusedBorder: _outlineBorder(colorTheme.secondary),
            errorBorder: _outlineBorder(colorTheme.error),
            focusedErrorBorder: _outlineBorder(colorTheme.error),
          ),
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
