import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/ui/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarSection extends StatefulWidget {
  const SearchBarSection({super.key});

  @override
  State<SearchBarSection> createState() => _SearchBarSectionState();
}

class _SearchBarSectionState extends State<SearchBarSection> {
  final TextEditingController _controller = TextEditingController();
  bool isSearching = false;

  void _onSearchChanged(String value) {
    setState(() {
      isSearching = value.isNotEmpty;
    });

    context.read<HomeViewModel>().searchWords(value);
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      isSearching = false;
    });

    context.read<HomeViewModel>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      height: 40,
      decoration: BoxDecoration(color: AppColors.primaryBackground, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: isSearching ? null : loc.search,
          hintStyle: AppTextStyle.body2.copyWith(color: AppColors.gray),
          border: InputBorder.none,

          /// search icon disappears when typing
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),

          /// mic icon becomes clear button when searching
          suffixIcon: isSearching
              ? IconButton(
                  icon: const Icon(Icons.close, color: AppColors.primary),
                  onPressed: _clearSearch,
                )
              : Container(
                  margin: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Color(0xFFE0E7FF), shape: BoxShape.circle),
                  child: const Icon(Icons.mic, size: 20, color: AppColors.primary),
                ),
        ),
      ),
    );
  }
}
