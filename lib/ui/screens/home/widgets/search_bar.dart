import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      height: 40,
      decoration: BoxDecoration(color: AppColors.primaryBackground, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
          hintText: loc.search,
          hintStyle: AppTextStyle.body2.copyWith(color: AppColors.gray),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          suffixIcon: Container(
            margin: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Color(0xFFE0E7FF), shape: BoxShape.circle),
            child: const Icon(Icons.mic, size: 20, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
