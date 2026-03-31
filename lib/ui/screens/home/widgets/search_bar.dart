import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/ui/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SearchBarSection extends StatefulWidget {
  const SearchBarSection({super.key});

  @override
  State<SearchBarSection> createState() => _SearchBarSectionState();
}

class _SearchBarSectionState extends State<SearchBarSection> {
  final TextEditingController _controller = TextEditingController();
  bool isSearching = false;
  Timer? _debounce;

  void _onSearchChanged(String value) {
    setState(() {
      isSearching = value.isNotEmpty;
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      context.read<HomeViewModel>().searchWords(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      isSearching = false;
    });

    context.read<HomeViewModel>().clearSearch();
    //context.read<HomeViewModel>().stopVoiceSearch();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeViewModel>().initSpeech();
    });
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
              : Consumer<HomeViewModel>(
                  builder: (context, vm, _) {
                    return IconButton(
                      icon: Icon(vm.isListening ? Icons.mic : Icons.mic_none, color: AppColors.primary),
                      onPressed: () async {
                        if (vm.isListening) {
                          vm.stopVoiceSearch();
                        } else {
                          _controller.clear();
                          setState(() => isSearching = false);

                          await vm.startVoiceSearch((text) {
                            _controller.value = TextEditingValue(
                              text: text,
                              selection: TextSelection.collapsed(offset: text.length),
                            );

                            setState(() => isSearching = text.isNotEmpty);
                          });
                        }
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
