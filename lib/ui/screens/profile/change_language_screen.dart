import 'package:domra_tech/state/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/navigation_helper.dart';
import '../../widgets/actions/language_button.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    final localeProvider = context.read<LocaleProvider>();
    selectedLanguage = localeProvider.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localeProvider = context.read<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.language,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, size: 20)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: colorScheme.primary,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // Header text
              Text(
                t.chooseLanguage,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                t.description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600], height: 1.4),
              ),

              const SizedBox(height: 48),

              // Language Options
              // Khmer
              LanguageButton(
                language: 'Khmer/ខ្មែរ',
                imagePath: 'assets/imgs/cambodia.png',
                isSelected: selectedLanguage == 'km',
                onSelected: () {
                  setState(() => selectedLanguage = 'km');
                },
              ),

              const SizedBox(height: 16),

              // English
              LanguageButton(
                language: 'English/អង់គ្លេស',
                imagePath: 'assets/imgs/usa.png',
                isSelected: selectedLanguage == 'en',
                onSelected: () {
                  setState(() => selectedLanguage = 'en');
                },
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _applyLanguage(context, localeProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: Text(
                    t.continueBtn,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Apply language change
  void _applyLanguage(BuildContext context, LocaleProvider localeProvider) {
    final locale = Locale(selectedLanguage);
    localeProvider.setLocale(locale);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.languageChangedSuccessfully), backgroundColor: AppColors.success));

    context.goBack();
  }
}
