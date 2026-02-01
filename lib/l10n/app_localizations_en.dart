// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingTitle1 => 'Welcome to Domra';

  @override
  String get onboardingSubTitle1 =>
      'Your trilingual technical dictionary for Cambodia.';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get search => 'Search terms';

  @override
  String get khmerWord => 'Khmer Word';

  @override
  String get englishWord => 'English Word';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose your language';
}
