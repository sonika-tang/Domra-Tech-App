import 'package:domra_tech/core/config/theme.dart';
import 'package:domra_tech/state/provider/language_provider.dart';
// import 'package:domra_tech/ui/screens/test_language_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
// import 'ui/screens/authentication/login_screen.dart';
import 'routes/app_router.dart' show AppRouter;
import 'routes/app_routes.dart';

class DomraTech extends StatelessWidget {
  const DomraTech({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: AppTheme.lightTheme.textTheme.apply(
          fontFamily: languageProvider.locale.languageCode == 'km'
              ? 'NotoSansKhmer'
              : 'Roboto',
        ),
      ),
      locale: languageProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // home: const TestLangScreen(),
      // home: const WelcomeScreen(),
      initialRoute: AppRoutes.onboarding1,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
