import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:domra_tech/ui/widgets/inputs/text_field.dart';
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
    // TODO: Replace with your repository or API call
    // Example: final word = await WordRepository.getWordById(wordId);

    // Mock data for now:
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
      _khmerController.text = word.khmerWord ?? "";
      _frenchController.text = word.frenchWord ?? "";
      _definitionController.text = word.definition ?? "";
      _exampleController.text = word.example ?? "";
      _referenceController.text = word.reference ?? "";
      _loading = false;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedWord = WordTranslation(
        wordId: widget.wordId,
        englishWord: _englishController.text,
        khmerWord: _khmerController.text,
        frenchWord: _frenchController.text,
        definition: _definitionController.text,
        example: _exampleController.text,
        reference: _referenceController.text,
      );

      // TODO: Call your repository or API to update
      // Example: await WordRepository.updateWord(updatedWord);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Word updated successfully")));
    }
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    String appTiitle = loc.request;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(appTiitle, style: AppTextStyle.heading3.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputTextField(controller: _englishController, text: "English Word", title: loc.englishWord),
                    InputTextField(controller: _khmerController, text: "Khmer Word", title: loc.khmerWord),
                    InputTextField(controller: _frenchController, text: "French Word", title: loc.frenchWord),
                    InputTextField(controller: _khmerController, text: "French Word", title: loc.khmerWord),

                    const SizedBox(height: 20),
                    PrimaryButton(label: loc.request, onPressed: () {}),
                  ],
                ),
              ),
            ),
    );
  }
}
