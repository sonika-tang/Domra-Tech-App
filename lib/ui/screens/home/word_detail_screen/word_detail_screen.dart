import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/state/models/favorite_state.dart';
import 'package:domra_tech/ui/screens/contributions/word_correction_form.dart';
import 'package:domra_tech/ui/screens/home/word_detail_screen/word_detail_screen_view_model.dart';
import 'package:domra_tech/ui/widgets/actions/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WordDetailScreen extends StatelessWidget {
  final WordTranslation word;

  const WordDetailScreen({super.key, required this.word});
  Future<String?> _getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'jwt');
  }

  void onRequest(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WordRequestForm(word: word)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (_) => WordDetailViewModel(word),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(loc.wordDetail, style: AppTextStyle.heading3.copyWith(color: Colors.white)),
          centerTitle: true,
        ),
        body: Consumer<WordDetailViewModel>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildWordSection(vm.word)),
                        _buildActionsSection(context, vm),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    _buildSectionTitle(loc.definition, vm.word.definition ?? "No definition.", chipLabel: "Computer science"),

                    const SizedBox(height: AppSpacing.s16),

                    _buildSectionTitle(loc.example, vm.word.example ?? loc.noExample),

                    const SizedBox(height: AppSpacing.s16),

                    _buildPictureSection(loc.picture),

                    const SizedBox(height: 24),

                    Text(loc.reference, style: AppTextStyle.buttonText),

                    vm.word.referenceText != null ? _buildReferenceItem(vm.word.referenceText!) : const Text("No reference"),

                    vm.word.reference != null ? _buildReferenceItem(vm.word.reference!) : const Text("No reference"),

                    const SizedBox(height: 40),

                    PrimaryButton(label: loc.request, onPressed: () => onRequest(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // FAVORITE AND SHARE BUTTONS
  Widget _buildActionsSection(BuildContext context, WordDetailViewModel vm) {
    return Row(
      children: [
        IconButton(
          onPressed: vm.shareWord,
          icon: const Icon(Icons.ios_share, color: AppColors.primary),
        ),
        Consumer<FavoriteNotifier>(
          builder: (context, favoriteNotifier, _) {
            final isFav = favoriteNotifier.state.favorites.any((w) => w.wordId == word.wordId);

            return IconButton(
              onPressed: () async {
                final token = await _getToken();
                if (token != null) {
                  await favoriteNotifier.toggleFavorite(word, token);
                }
              },
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : AppColors.primary),
            );
          },
        ),
      ],
    );
  }

  // WORD SECTION
  Widget _buildWordSection(WordTranslation word) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wordTitle(word.englishWord ?? "No word found"),
        const SizedBox(height: AppSpacing.s16),
        _wordTitle(word.khmerWord),
        const SizedBox(height: AppSpacing.s16),
        _wordTitle(word.frenchWord ?? "No word found"),
      ],
    );
  }

  Widget _wordTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.body1.copyWith(color: AppColors.primary),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSectionTitle(String title, String description, {String? chipLabel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Text(description, style: AppTextStyle.body2.copyWith(color: AppColors.gray)),
        const Divider(height: 32, thickness: 1.2, color: AppColors.primary),
      ],
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
          decoration: BoxDecoration(color: const Color(0xFFF0F2F8), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.image, size: 80, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildReferenceItem(String link) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(link.startsWith('http') ? link : 'https://$link');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          link,
          style: AppTextStyle.body2.copyWith(color: AppColors.primary, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
