import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:domra_tech/ui/screens/request_word_form/confirmation_screen.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../state/models/contribution_state.dart';
import '../../../service/word_service.dart';
import '../../../data/repo/word_repository.dart';
import 'package:http/http.dart' as http;

class WordRequestForm extends StatefulWidget {
  final int wordId;
  const WordRequestForm({super.key, required this.wordId});

  @override
  State<WordRequestForm> createState() => _WordRequestFormState();
}

class _WordRequestFormState extends State<WordRequestForm> {
  final _formKey = GlobalKey<FormState>();

  final _englishController = TextEditingController();
  final _khmerController = TextEditingController();
  final _frenchController = TextEditingController();
  final _definitionController = TextEditingController();
  final _exampleController = TextEditingController();
  final _referenceController = TextEditingController();

  XFile? _selectedImage;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchWord(widget.wordId);
  }

  Future<void> _fetchWord(int wordId) async {
    try {
      final wordRepo = WordRepository(WordService(http.Client()));
      final word = await wordRepo.getWordById(wordId);

      if (word != null) {
        setState(() {
          _englishController.text = word.englishWord ?? "";
          _khmerController.text = word.khmerWord;
          _frenchController.text = word.frenchWord ?? "";
          _definitionController.text = word.definition ?? "";
          _exampleController.text = word.example ?? "";
          _referenceController.text = word.reference ?? "";
          _imageUrl = word.imageURL;
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (e) {
      debugPrint("Error fetching word: $e");
      setState(() => _loading = false);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F51B5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Word Request", style: AppTextStyle.heading3.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<ContributionNotifier>(
              builder: (context, notifier, child) {
                return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Rounded Filled Style Fields ---
                    _buildLabel(loc.englishWord),
                    _buildRoundedField(_englishController, "Machine learning (ml)"),

                    _buildLabel(loc.khmerWord),
                    _buildRoundedField(_khmerController, "សិក្សាម៉ាស៊ីន"),

                    _buildLabel(loc.frenchWord),
                    _buildRoundedField(_frenchController, "machine learning (m.)/"),

                    const SizedBox(height: 20),

                    // --- Underline Style Fields ---
                    _buildUnderlineField(_definitionController, "Definition"),
                    _buildUnderlineField(_referenceController, "Reference"),
                    _buildUnderlineField(_exampleController, "Example"),

                    const SizedBox(height: 30),

                    // --- Image Upload Placeholder ---
                    _buildImagePicker(),

                    const SizedBox(height: 40),

                    // --- Submit Button ---
                    notifier.state.isLoading 
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          label: "Submit Update",
                          // Custom color to match the orange in your image
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final data = {
                                'wordId': widget.wordId,
                                'correctEnglish': _englishController.text.isEmpty ? null : _englishController.text,
                                'correctKhmer': _khmerController.text.isEmpty ? null : _khmerController.text,
                                'correctFrench': _frenchController.text.isEmpty ? null : _frenchController.text,
                                'definition': _definitionController.text.isEmpty ? null : _definitionController.text,
                                'reference': _referenceController.text.isEmpty ? null : _referenceController.text,
                                'example': _exampleController.text.isEmpty ? null : _exampleController.text,
                              };

                              final success = await notifier.submitCorrection(data, imageFile: _selectedImage);

                              if (mounted) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Improvement submitted!'), backgroundColor: Colors.green));
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ConfirmationScreen()));
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
            );
          },
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
