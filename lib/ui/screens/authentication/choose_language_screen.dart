import 'package:domra_tech/state/provider/language_provider.dart';
import 'package:domra_tech/ui/widgets/actions/language_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/actions/primary_button.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    if (t == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final provider = Provider.of<LocaleProvider>(context);
    final selectedLocale = provider.locale;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.s48),
          Image.asset("assets/imgs/Domra_Tech-logo-Transparent.png", height: 200),
          const SizedBox(height: AppSpacing.s32),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.s24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(t.chooseLanguage, style: AppTextStyle.heading1.copyWith(color: AppColors.background)),
                  ),

                  const SizedBox(height: AppSpacing.s24),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LanguageButton(
                          language: "English/អង់គ្លេស",
                          imagePath: "assets/imgs/usa.png",
                          isSelected: selectedLocale.languageCode == 'en',
                          onSelected: () => provider.setLocale(const Locale('en')),
                        ),
                        const SizedBox(height: 12),
                        LanguageButton(
                          language: "Khmer/ភាសាខ្មែរ",
                          imagePath: "assets/imgs/cambodia.png",
                          isSelected: selectedLocale.languageCode == 'km',
                          onSelected: () => provider.setLocale(const Locale('km')),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  PrimaryButton(
                    label: t.confirm,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.welcome);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
