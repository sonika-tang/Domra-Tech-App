import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../state/models/contribution_state.dart';

class SubmitCorrectionScreen extends StatefulWidget {
  final int? wordId;
  const SubmitCorrectionScreen({super.key, this.wordId});

  @override
  State<SubmitCorrectionScreen> createState() => _SubmitCorrectionScreenState();
}

class _SubmitCorrectionScreenState extends State<SubmitCorrectionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _englishController = TextEditingController();
  final _khmerController = TextEditingController();
  final _frenchController = TextEditingController();
  final _definitionController = TextEditingController();
  final _referenceController = TextEditingController();
  final _exampleController = TextEditingController();

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

  void _submitCorrection() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    // Require at least one correction field to be filled
    if (_englishController.text.isEmpty && 
        _khmerController.text.isEmpty && 
        _frenchController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide at least one correction.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final data = {
      'wordId': widget.wordId ?? 1, // Fallback to 1 for mock purposes if none provided
      'correctEnglish': _englishController.text.isEmpty ? null : _englishController.text,
      'correctKhmer': _khmerController.text.isEmpty ? null : _khmerController.text,
      'correctFrench': _frenchController.text.isEmpty ? null : _frenchController.text,
      'definition': _definitionController.text.isEmpty ? null : _definitionController.text,
      'reference': _referenceController.text.isEmpty ? null : _referenceController.text,
      'example': _exampleController.text.isEmpty ? null : _exampleController.text,
    };

    final notifier = Provider.of<ContributionNotifier>(context, listen: false);
    final success = await notifier.submitCorrection(data);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Improvement submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back after success
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Request', style: TextStyle(color: Colors.white)), // Keeping title same as design Image 4
        centerTitle: true,
        backgroundColor: const Color(0xFF3B5998),
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
                  _buildLabel('English word'),
                  _buildTextField(_englishController, 'Machine learning (ml)'), // Mock placeholder
                  const SizedBox(height: 16),
                  
                  _buildLabel('Khmer word'),
                  _buildTextField(_khmerController, 'សិក្សាម៉ាស៊ីន'), // Mock placeholder
                  const SizedBox(height: 16),
                  
                  _buildLabel('French word'),
                  _buildTextField(_frenchController, 'machine learning (m.)/'), // Mock placeholder
                  const SizedBox(height: 24),
                  
                  _buildLabel('Definition', isUnderline: true),
                  _buildUnderlineTextField(_definitionController),
                  const SizedBox(height: 16),
                  
                  _buildLabel('Reference', isUnderline: true),
                  _buildUnderlineTextField(_referenceController),
                  const SizedBox(height: 16),
                  
                  _buildLabel('Example', isUnderline: true),
                  _buildUnderlineTextField(_exampleController),
                  const SizedBox(height: 24),
                  
                  // Image upload placeholder
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF3B5998).withValues(alpha: .3),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B5998),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitCorrection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEDB151),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Submit Update',
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
          color: isUnderline ? Colors.grey : const Color(0xFF3B5998),
          fontSize: 14,
          fontWeight: isUnderline ? FontWeight.normal : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
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
