import 'dart:io';
import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../state/models/contribution_state.dart';

class SubmitWordRequestScreen extends StatefulWidget {
  const SubmitWordRequestScreen({super.key});

  @override
  State<SubmitWordRequestScreen> createState() =>
      _SubmitWordRequestScreenState();
}

class _SubmitWordRequestScreenState extends State<SubmitWordRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final _englishController = TextEditingController();
  final _khmerController = TextEditingController();
  final _frenchController = TextEditingController();
  final _definitionController = TextEditingController();
  final _referenceController = TextEditingController();
  final _exampleController = TextEditingController();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  void dispose() {
    _englishController.dispose();
    _khmerController.dispose();
    _frenchController.dispose();
    _definitionController.dispose();
    _referenceController.dispose();
    _exampleController.dispose();
    super.dispose();
  }

  void _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final data = {
      'newEnglishWord': _englishController.text,
      'newKhmerWord': _khmerController.text,
      'newFrenchWord': _frenchController.text.isEmpty
          ? null
          : _frenchController.text,
      'newDefinition': _definitionController.text.isEmpty
          ? null
          : _definitionController.text,
      'reference': _referenceController.text.isEmpty
          ? null
          : _referenceController.text,
      'newExample': _exampleController.text.isEmpty
          ? null
          : _exampleController.text,
    };

    final notifier = Provider.of<ContributionNotifier>(context, listen: false);
    final success = await notifier.submitWordRequest(
      data,
      imageFile: _selectedImage,
    );

    if (mounted) {
      if (success) {
        Navigator.pushNamed(context, '/contribution-confirmation');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(notifier.state.error ?? 'Submission failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ContributionNotifier>().state;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.wordRequest,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(loc.englishWord),
                    _buildTextField(
                      _englishController,
                      loc.englishWord,
                      required: true,
                    ),
                    const SizedBox(height: 16),

                    _buildLabel(loc.khmerWord),
                    _buildTextField(_khmerController, loc.khmerWord),
                    const SizedBox(height: 16),

                    _buildLabel(loc.frenchWord),
                    _buildTextField(_frenchController, loc.frenchWord),
                    const SizedBox(height: 24),

                    _buildLabel(loc.definition, isUnderline: true),
                    _buildUnderlineTextField(_definitionController),
                    const SizedBox(height: 16),

                    _buildLabel(loc.reference, isUnderline: true),
                    _buildUnderlineTextField(_referenceController),
                    const SizedBox(height: 16),

                    _buildLabel(loc.example, isUnderline: true),
                    _buildUnderlineTextField(_exampleController),
                    const SizedBox(height: 24),

                    // Image upload placeholder
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0FA),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(
                              0xFF3B5998,
                            ).withValues(alpha: .3),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: kIsWeb
                                    ? Image.network(
                                        _selectedImage!.path,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )
                                    : Image.file(
                                        File(_selectedImage!.path),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                              )
                            : Center(
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.add_photo_alternate,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEDB151),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                loc.submit,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLabel(String text, {bool isUnderline = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: isUnderline ? Colors.grey : AppColors.primary,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: const Color(0xFFF0F0FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: required
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildUnderlineTextField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3B5998), width: 1.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3B5998), width: 2.0),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
