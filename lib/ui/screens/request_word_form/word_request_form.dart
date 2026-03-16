import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/ui/screens/request_word_form/confirmation_screen.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';

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

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchWord(widget.wordId);
  }

  Future<void> _fetchWord(int wordId) async {
    // Mocking the fetch process
    await Future.delayed(const Duration(milliseconds: 500));
    final word = WordTranslation(
      wordId: wordId,
      englishWord: "Machine learning (ml)",
      khmerWord: "សិក្សាម៉ាស៊ីន",
      frenchWord: "machine learning (m.)",
      definition: "",
      example: "",
      reference: "",
    );

    setState(() {
      _englishController.text = word.englishWord ?? "";
      _khmerController.text = word.khmerWord;
      _frenchController.text = word.frenchWord ?? "";
      _loading = false;
    });
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
          : SingleChildScrollView(
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
                    PrimaryButton(
                      label: "Submit Update",
                      // Custom color to match the orange in your image
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // 1. Perform your API call here

                          // 2. Navigate to the confirmation screen
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ConfirmationScreen()));
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
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3F51B5).withOpacity(0.5), style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFFEFF2F9), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.image, size: 60, color: Color(0xFF3F51B5)),
        ),
      ),
    );
  }
}
