import 'package:domra_tech/state/provider/language_provider.dart';
import 'package:domra_tech/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'state/models/auth_state.dart';
import 'state/models/user_state.dart';
import 'state/models/word_state.dart';
import 'state/models/favorite_state.dart';
import 'state/models/contribution_state.dart';
import 'state/models/payment_state.dart';
import 'l10n/app_localizations.dart';
import 'routes/app_router.dart';
import 'core/config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // Language provider (existing)
        ChangeNotifierProvider(create: (context) => LocaleProvider()),

        // State management providers (new)
        ChangeNotifierProvider(create: (context) => AuthNotifier()),
        ChangeNotifierProvider(create: (context) => UserNotifier()),
        ChangeNotifierProvider(create: (context) => WordNotifier()),
        ChangeNotifierProvider(create: (context) => FavoriteNotifier()),
        ChangeNotifierProvider(create: (context) => ContributionNotifier()),
        ChangeNotifierProvider(create: (context) => PaymentNotifier()),
      ],
      child: const DomraTech(),
    ),
  );
}

/// Updated DomraTech widget with proper state and navigation
class DomraTech extends StatelessWidget {
  const DomraTech({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Domra Tech',
          theme: AppTheme.lightTheme.copyWith(
            textTheme: AppTheme.lightTheme.textTheme.apply(
              fontFamily: localeProvider.locale.languageCode == 'km'
                  ? 'NotoSansKhmer'
                  : 'Roboto',
            ),
          ),
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateRoute: AppRouter.generateRoute,
          home: ProfileScreen(),
        );
      },
    );
  }

  /// Build home screen based on authentication state
  Widget _buildHome(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authNotifier, _) {
        final authState = authNotifier.state;

        // If not logged in, show login screen
        if (!authState.isLoggedIn) {
          return const LoginPlaceholder();
        }

        // If first time, show onboarding
        if (authState.isFirstTime) {
          return const OnboardingPlaceholder();
        }

        // Otherwise show main app with bottom navigation
        return const MainAppScreen();
      },
    );
  }
}

/// Main app screen with bottom navigation
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home
          const Center(child: Text('Home')),
          // Contribute
          const Center(child: Text('Contribute')),
          // Favorite
          const Center(child: Text('Favorite')),
          // Profile - Using ProfileScreen from app.dart
          // You can replace this with actual ProfileScreen when ready
          const Center(child: Text('Profile')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Contribute'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

/// Placeholder for login screen
class LoginPlaceholder extends StatelessWidget {
  const LoginPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Auto-login for testing
            context.read<AuthNotifier>().login('test@example.com', 'password');
          },
          child: const Text('Auto Login (For Testing)'),
        ),
      ),
    );
  }
}

/// Placeholder for onboarding
class OnboardingPlaceholder extends StatelessWidget {
  const OnboardingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthNotifier>().completeOnboarding();
          },
          child: const Text('Complete Onboarding'),
        ),
      ),
    );
  }
}
