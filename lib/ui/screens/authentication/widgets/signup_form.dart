import 'package:flutter/material.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/actions/primary_button.dart';
import '../../../widgets/inputs/password_field.dart';
import '../../../widgets/inputs/text_field.dart';

class SignupForm extends StatefulWidget {
  final void Function(Map<String, dynamic> userData) onSubmit;
  final String? errorMessage;
  final VoidCallback? onInputChanged;

  const SignupForm({
    super.key,
    required this.onSubmit,
    this.errorMessage,
    this.onInputChanged,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _gender;
  DateTime? _dob;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                loc.signUp,
                style: AppTextStyle.heading1.copyWith(
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: AppSpacing.s24),

              // First name
              InputTextField(
                title: loc.firstName,
                text: loc.enterFirstName,
                controller: _firstNameController,
                validator: (value) => value == null || value.isEmpty
                    ? "First name required"
                    : null,
              ),
              const SizedBox(height: AppSpacing.s16),

              // Last name
              InputTextField(
                title: loc.lastName,
                text: loc.enterLastName,
                controller: _lastNameController,
                validator: (value) => value == null || value.isEmpty
                    ? "Last name required"
                    : null,
              ),
              const SizedBox(height: AppSpacing.s16),

              // Email
              InputTextField(
                title: loc.email,
                text: loc.enterEmail,
                controller: _emailController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Email required" : null,
              ),
              const SizedBox(height: AppSpacing.s16),

              // Password
              InputPasswordField(
                title: loc.password,
                hint: loc.enterPassword,
                controller: _passwordController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Password required" : null,
              ),
              const SizedBox(height: AppSpacing.s16),

              // Gender dropdown
              DropdownButtonFormField<String>(
                value: _gender,
                items: ["Male", "Female", "Other"]
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => _gender = val),
                decoration: InputDecoration(labelText: loc.gender),
                validator: (val) => val == null ? "Select gender" : null,
              ),
              const SizedBox(height: AppSpacing.s16),

              // Date of birth picker
              TextButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _dob = picked);
                },
                child: Text(
                  _dob == null
                      ? loc.chooseDate
                      : "${_dob!.day}/${_dob!.month}/${_dob!.year}",
                  style: AppTextStyle.body2.copyWith(
                    color: AppColors.background,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s24),

              // Submit button
              PrimaryButton(
                label: loc.signUp,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final userData = {
                      "firstName": _firstNameController.text.trim(),
                      "lastName": _lastNameController.text.trim(),
                      "email": _emailController.text.trim(),
                      "password": _passwordController.text.trim(),
                      "gender": _gender,
                      "dob": _dob?.toIso8601String(),
                    };
                    widget.onSubmit(userData);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
