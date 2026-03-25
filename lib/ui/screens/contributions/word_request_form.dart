import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/model/word_translation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../state/models/contribution_state.dart';

class WordRequestForm extends StatefulWidget {
  /// The word from the card the user tapped — pre-populates all fields.
  final WordTranslation word;

  const WordRequestForm({super.key, required this.word, int? wordId});

  @override
  State<WordRequestForm> createState() => _WordRequestFormState();
}

class _WordRequestFormState extends State<WordRequestForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _englishController;
  late final TextEditingController _khmerController;
  late final TextEditingController _frenchController;
  late final TextEditingController _definitionController;
  late final TextEditingController _exampleController;
  late final TextEditingController _referenceController;

  XFile? _selectedImage;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Pre-populate all fields from the word card that was tapped
    final w = widget.word;
    _englishController    = TextEditingController(text: w.englishWord ?? '');
    _khmerController      = TextEditingController(text: w.khmerWord);
    _frenchController     = TextEditingController(text: w.frenchWord ?? '');
    _definitionController = TextEditingController(text: w.definition ?? '');
    _exampleController    = TextEditingController(text: w.example ?? '');
    _referenceController  = TextEditingController(text: w.reference ?? '');
    _imageUrl             = w.imageURL;
  }

  @override
  void dispose() {
    _englishController.dispose();
    _khmerController.dispose();
    _frenchController.dispose();
    _definitionController.dispose();
    _exampleController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _imageUrl = null; // user picked a new image, clear old URL
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final notifier = context.read<ContributionNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Word Request',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3B5998),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Rounded Filled Style Fields ---
              _buildLabel(loc.englishWord),
              _buildRoundedField(_englishController, loc.englishWord),

              _buildLabel(loc.khmerWord),
              _buildRoundedField(_khmerController, loc.khmerWord),

              _buildLabel(loc.frenchWord),
              _buildRoundedField(_frenchController, loc.frenchWord),

              const SizedBox(height: 20),

              // --- Underline Style Fields ---
              _buildUnderlineField(_definitionController, "Definition"),
              _buildUnderlineField(_referenceController, "Reference"),
              _buildUnderlineField(_exampleController, "Example"),

              const SizedBox(height: 30),

              // --- Image picker ---
              _buildImagePicker(),

              const SizedBox(height: 40),

              // --- Submit Button ---
              notifier.state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    label: "Submit Update",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          'wordId': widget.word.wordId,
                          'correctEnglishWord': _englishController.text.isEmpty ? null : _englishController.text,
                          'correctKhmerWord': _khmerController.text.isEmpty ? null : _khmerController.text,
                          'correctFrenchWord': _frenchController.text.isEmpty ? null : _frenchController.text,
                          // 'definition': _definitionController.text.isEmpty ? null : _definitionController.text,
                          'reference': _referenceController.text.isEmpty ? null : _referenceController.text,
                          // 'example': _exampleController.text.isEmpty ? null : _exampleController.text,
                        };

                        final success = await notifier.submitCorrection(data, imageFile: _selectedImage);

                        if (mounted) {
                          if (success) {
                            Navigator.pushNamed(context, '/contribution-confirmation');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notifier.state.error ?? 'Submission failed'), backgroundColor: Colors.red));
                          }
                        }
                      }
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for Section Labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 12.0),
      child: Text(
        text,
        style: AppTextStyle.body1.copyWith(color: const Color(0xFF3F51B5), fontWeight: FontWeight.w500),
      ),
    );
  }

  // Rounded Input (English/Khmer/French)
  Widget _buildRoundedField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFEFF2F9), borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        style: AppTextStyle.body2.copyWith(color: Colors.grey[700]),
        decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), border: InputBorder.none),
      ),
    );
  }

  // Underline Input (Definition/Reference/Example)
  Widget _buildUnderlineField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyle.body2.copyWith(color: Colors.grey[400]),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF3F51B5), width: 1.5)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF3F51B5), width: 2)),
        ),
      ),
    );
  }

  // Dotted Image Picker Box
  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF3F51B5).withOpacity(0.5), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: kIsWeb
                  ? Image.network(_selectedImage!.path, fit: BoxFit.cover, width: double.infinity)
                  : Image.file(File(_selectedImage!.path), fit: BoxFit.cover, width: double.infinity),
            )
          : _imageUrl != null && _imageUrl!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(_imageUrl!, fit: BoxFit.cover, width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                  ),
                )
              : Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: const Color(0xFFEFF2F9), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.add_photo_alternate, size: 60, color: Color(0xFF3F51B5)),
                  ),
                ),
      ),
    );
  }
}
