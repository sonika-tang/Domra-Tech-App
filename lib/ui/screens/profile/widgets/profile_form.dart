import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;

  // For the sake of matching the mockup, we add dummy gender and dob controllers
  // In a real app these would be connected to the userState
  final TextEditingController genderController;
  final TextEditingController dobController;
  final VoidCallback onGenderTap;
  final VoidCallback onDobTap;

  const ProfileForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.genderController,
    required this.dobController,
    required this.onGenderTap,
    required this.onDobTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCustomField(label: t.firstName, controller: firstNameController),
        const SizedBox(height: 16),
        _buildCustomField(label: t.lastName, controller: lastNameController),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onGenderTap,
                child: AbsorbPointer(
                  child: _buildCustomField(
                    label: t.gender,
                    controller: genderController,
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF3F51B5),
                    ),
                    readOnly: true,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: onDobTap,
                child: AbsorbPointer(
                  child: _buildCustomField(
                    label: t.dob,
                    controller: dobController,
                    suffixIcon: const Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: Color(0xFF3F51B5),
                    ),
                    readOnly: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildCustomField(
          label: t.emailAddress,
          controller: emailController,
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildCustomField({
    required String label,
    required TextEditingController controller,
    Widget? suffixIcon,
    bool readOnly = false,
  }) {
    // using similar colors to the mockup:
    // label is greyish, input background is light blue-grey, text is dark blue
    const Color inputBackgroundColor = Color(0xFFEBEFF7);
    const Color inputTextColor = Color(0xFF3F51B5);
    const Color labelColor = Color(0xFF9E9E9E);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: labelColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          style: const TextStyle(
            color: inputTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: inputBackgroundColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
