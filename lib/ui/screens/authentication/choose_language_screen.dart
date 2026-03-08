import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/language_provider.dart';
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

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.s48),
          Image.asset(
            "assets/imgs/Domra_Tech-logo-Transparent.png",
            height: 180,
          ),
          const SizedBox(height: AppSpacing.s32),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.s24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.chooseLanguage,
                    style: AppTextStyle.heading1.copyWith(
                      color: AppColors.background,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.s24),

                  // English option
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RadioListTile<Locale>(
                      value: const Locale('en'),
                      groupValue: provider.locale,
                      onChanged: (locale) => provider.setLocale(locale!),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/imgs/usa.png", width: 32),
                          const SizedBox(width: 12),
                          Text("English/អង់គ្លេស",
                            style: AppTextStyle.body1.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      activeColor: AppColors.secondary, 
                      controlAffinity:
                          ListTileControlAffinity.trailing, 
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RadioListTile<Locale>(
                      value: const Locale('km'),
                      groupValue: provider.locale,
                      onChanged: (locale) => provider.setLocale(locale!),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/imgs/cambodia.webp", width: 32),
                          const SizedBox(width: 12),
                          Text(
                            "Khmer/ភាសាខ្មែរ",
                            style: AppTextStyle.body1.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      activeColor: AppColors.secondary,
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),

                  const Spacer(),

                  PrimaryButton(
                    label: t.confirm,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.welcome,
                      );
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
