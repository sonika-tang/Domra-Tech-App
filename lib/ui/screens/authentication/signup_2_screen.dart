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
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            "assets/imgs/Domra_Tech-logo-Transparent.png",
            height: 200,
          ),
          const Spacer(),
          Container(
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
              child: Column(
                children: [
                  Text(
                    loc.setupAccount,
                    style: AppTextStyle.heading1.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s24),
                  InputTextField(
                    title: loc.firstName,
                    text: loc.enterFirstName,
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  InputTextField(
                    title: loc.lastName,
                    text: loc.enterLastName,
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _gender,
                        items: ["Male", "Female", "Other"]
                            .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                            .toList(),
                        onChanged: (val) => setState(() => _gender = val),
                        decoration: InputDecoration(labelText: loc.gender),
                      ),
                      const SizedBox(height: AppSpacing.s16),
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
        ],
      ),
    );
  }
}
