import 'package:domra_tech/model/word_translation.dart';
import 'package:flutter/material.dart';
import '../../../core/config/app_text_style.dart';

class WordCard extends StatelessWidget {
  final VoidCallback onClick;
  final WordTranslation wordTranslation;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final bool isFavorite;

  const WordCard({
    super.key,
    required this.wordTranslation,
    required this.onClick,
    required this.onFavorite,
    required this.onShare,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onClick, //click to see detail of each card
        child: Container(
          width: double.infinity,
          height: 110,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: colorScheme.secondary,
                width: AppSpacing.s4,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWordColumn(textTheme, colorScheme),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        IconButton(
          onPressed: onFavorite,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
        ),
        const SizedBox(width: AppSpacing.s4),
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.ios_share_rounded),
        ),
      ],
    );
  }

  Widget _buildWordColumn(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(wordTranslation.englishWord!, style: textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.s4),
        Text(
          wordTranslation.khmerWord,
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
        ),
      ],
    );
  }
}
