import 'package:domra_tech/ui/screens/authentication/widgets/date_picker.dart';
import 'package:domra_tech/ui/screens/authentication/widgets/dropdown.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/actions/primary_button.dart';
import '../../widgets/inputs/text_field.dart';

class SignupScreen2 extends StatefulWidget {
  final Map<String, dynamic> signupData;
  const SignupScreen2({super.key, required this.signupData});

  @override
  State<SignupScreen2> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _gender;
  DateTime? _dob;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          // Logo area
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/imgs/Domra_Tech-logo-Transparent.png",
                height: size.height * 0.28,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Form panel pinned to bottom
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.s24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      loc.setupAccount,
                      style: AppTextStyle.heading1.copyWith(
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // First name – required
                    InputTextField(
                      title: loc.firstName,
                      text: loc.enterFirstName,
                      controller: _firstNameController,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? loc.firstName : null,
                    ),
                    const SizedBox(height: AppSpacing.s16),

                    // Last name – required
                    InputTextField(
                      title: loc.lastName,
                      text: loc.enterLastName,
                      controller: _lastNameController,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? loc.lastName : null,
                    ),
                    const SizedBox(height: AppSpacing.s16),

                    // Gender + DOB side by side
                    Row(
                      children: [
                        Expanded(
                          child: StyledDropdown(
                            title: "Select gender",
                            hint: "Choose gender",
                            value: _gender,
                            items: ["Male", "Female", "Other"],
                            onChanged: (val) =>
                                setState(() => _gender = val),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StyledDatePicker(
                            title: "Date of birth",
                            hint: "Choose date",
                            selectedDate: _dob,
                            onDateSelected: (date) =>
                                setState(() => _dob = date),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.s24),

                    PrimaryButton(
                      label: loc.next,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final data = {
                            ...widget.signupData,
                            "firstName": _firstNameController.text.trim(),
                            "lastName": _lastNameController.text.trim(),
                            "gender": _gender,
                            "dob": _dob?.toIso8601String(),
                          };
                          Navigator.pushNamed(
                            context,
                            AppRoutes.signup3,
                            arguments: data,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
