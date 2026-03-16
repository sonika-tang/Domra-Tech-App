import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/ui/screens/request_word_form/word_request_form.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WordDetailScreen extends StatefulWidget {
  final WordTranslation word;

  const WordDetailScreen({super.key, required this.word});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  //String get example => word.example ??
  void onRequest() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WordRequestForm(wordId: widget.word.wordId)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    String appTiitle = loc.wordDetail;

    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TRANSLATE WORD
                  _buildWordSection(),
                  //BUTTON : FAVORITE AND SHARE
                  _buildActionsSection(),
                ],
              ),
              const SizedBox(height: AppSpacing.s24),
              // Definition Section
              _buildSectionTitle(loc.definition, widget.word.definition ?? "No definition.", chipLabel: "Computer science"),
              const SizedBox(height: AppSpacing.s16),

              // Example Section
              _buildSectionTitle(loc.example, widget.word.example ?? loc.noExample),
              const SizedBox(height: AppSpacing.s16),

              // Picture Placeholder
              const SizedBox(height: AppSpacing.s16),
              _buildPictureSection(loc.picture),
              const SizedBox(height: 24),

              // Reference Section
              Text(loc.reference, style: AppTextStyle.buttonText),
              _buildReferenceItem("គណៈកម្មការវិទ្យាសាស្ត្រ និងបច្ចេកវិទ្យា."),
              _buildReferenceItem("www.facebook.com"),

              const SizedBox(height: 40),
              // Bottom Request Button
              PrimaryButton(label: loc.request, onPressed: onRequest),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPictureSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.buttonText),
        const SizedBox(height: AppSpacing.s16),
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.3), style: BorderStyle.solid),
          ),
          child: const Icon(Icons.image, size: 80, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String description, {String? chipLabel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Titile section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyle.buttonText),
            if (chipLabel != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primaryBackground, borderRadius: BorderRadius.circular(12)),
                child: Text(chipLabel, style: const TextStyle(fontSize: 10, color: AppColors.primary)),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.s16),
        //Description
        Text(description, style: AppTextStyle.body2.copyWith(color: AppColors.gray)),
        //Divider
        const Divider(height: 32, thickness: 1.2, color: AppColors.primary),
      ],
    );
  }

  Widget _buildReferenceItem(String link) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final uri = Uri.parse(link);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  // Handle error (e.g., show a snackbar)
                  debugPrint("Could not launch $link");
                }
              },
              child: Text(
                link,
                style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse(link);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: const Text(
              "[Link]",
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  //Trillingual word section
  Widget _buildWordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wordTitle(widget.word.englishWord ?? "No word found"),
        const SizedBox(height: AppSpacing.s16),
        _wordTitle(widget.word.khmerWord),
        const SizedBox(height: AppSpacing.s16),
        _wordTitle(widget.word.frenchWord ?? "No word found"),
      ],
    );
  }

  //Word title
  Widget _wordTitle(String title) {
    return Text(title, style: AppTextStyle.body1.copyWith(color: AppColors.primary));
  }

  //Action button section
  Widget _buildActionsSection() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.ios_share, color: AppColors.primary),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border, color: AppColors.primary),
        ),
      ],
    );
  }
}
