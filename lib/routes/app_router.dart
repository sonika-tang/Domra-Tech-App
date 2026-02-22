/// Main router implementation for the Domra app

import 'package:domra_tech/routes/route_params.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

// TODO: Import all screens here
// import 'package:domra/ui/screens/onboarding/onboarding_screen_1.dart';
// import 'package:domra/ui/screens/authentication/login_screen.dart';
// ... etc

/// Main router class responsible for generating routes
class AppRouter {
  AppRouter._(); // Prevent instantiation

  /// Called when Navigator.pushNamed() is invoked
  /// Maps route names to screen widgets
  /// Properly extracts and types parameters for each model
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Extract arguments
    final args = settings.arguments as Map<String, dynamic>? ?? {};

    // Log navigation for debugging
    debugPrint('Navigating to: ${settings.name}');

    // Route generation - map route names to screens
    switch (settings.name) {
      // 
      // ONBOARDING ROUTES
      // 
      case AppRoutes.onboarding1:
        return _fadeRoute(const OnboardingScreen1(), settings);

      case AppRoutes.onboarding2:
        return _fadeRoute(const OnboardingScreen2(), settings);

      case AppRoutes.onboarding3:
        return _fadeRoute(const OnboardingScreen3(), settings);

      // 
      // AUTHENTICATION ROUTES
      // 
      case AppRoutes.chooseLanguage:
        return _fadeRoute(const ChooseLanguageScreen(), settings);

      case AppRoutes.welcome:
        return _slideRoute(const WelcomeScreen(), settings);

      case AppRoutes.login:
        return _slideRoute(const LoginScreen(), settings);

      case AppRoutes.signup1:
        return _slideRoute(const SignupScreen1(), settings);

      case AppRoutes.signup2:
        return _slideRoute(const SignupScreen2(), settings);

      case AppRoutes.signup3:
        return _slideRoute(const SignupScreen3(), settings);

      case AppRoutes.forgotPassword:
        return _slideRoute(const ForgotPasswordScreen(), settings);

      case AppRoutes.resetPassword:
        final email = args[RouteParams.email] as String? ?? '';
        return _slideRoute(ResetPasswordScreen(email: email), settings);

      // 
      // HOME & BROWSING ROUTES (WordTranslation from WordService)
      // 
      case AppRoutes.home:
        return _fadeRoute(const HomeScreen(), settings);

      case AppRoutes.wordDetail:
        // Extract WordTranslation parameters from WordService.getWordById()
        final wordId = args[RouteParams.wordId] as int? ?? 0;
        final englishWord = args[RouteParams.englishWord] as String?;
        final khmerWord = args[RouteParams.khmerWord] as String?;
        final frenchWord = args[RouteParams.frenchWord] as String?;
        final definition = args[RouteParams.definition] as String?;
        final example = args[RouteParams.example] as String?;
        final imageURL = args[RouteParams.imageURL] as String?;
        final reference = args[RouteParams.reference] as String?;

        return _slideRoute(
          WordDetailScreen(
            wordId: wordId,
            englishWord: englishWord,
            khmerWord: khmerWord,
            frenchWord: frenchWord,
            definition: definition,
            example: example,
            imageURL: imageURL,
            reference: reference,
          ),
          settings,
        );

      case AppRoutes.searchResults:
        // Search from WordService.searchWords(query)
        final query = args[RouteParams.searchQuery] as String? ?? '';
        final category = args[RouteParams.selectedCategory] as String?;

        return _slideRoute(
          SearchResultsScreen(query: query, category: category),
          settings,
        );

      // 
      // CONTRIBUTION ROUTES (WordRequest & CorrectionRequest)
      // 
      case AppRoutes.contributionGuideline:
        return _slideRoute(const ContributionGuidelineScreen(), settings);

      case AppRoutes.submitWordRequest:
        // Submit via RequestService.createWordRequest()
        // Creates WordRequest with: userId, newEnglishWord, newFrenchWord, etc.
        return _slideRoute(const SubmitWordRequestScreen(), settings);

      case AppRoutes.submitCorrection:
        // Submit via RequestService.createCorrectionRequest()
        // Creates CorrectionRequest with: userId, wordId, correctEnglish, etc.
        final wordId = args[RouteParams.correctionWordId] as int?;

        return _slideRoute(SubmitCorrectionScreen(wordId: wordId), settings);

      case AppRoutes.contributionConfirmation:
        // Confirmation after WordRequest or CorrectionRequest submission
        final type =
            args[RouteParams.contributionType] as String? ?? 'word_request';
        final wordRequestId = args[RouteParams.wordRequestId] as int?;
        final correctionId = args[RouteParams.correctionId] as int?;

        return _scaleRoute(
          ContributionConfirmationScreen(
            type: type,
            wordRequestId: wordRequestId,
            correctionId: correctionId,
          ),
          settings,
        );

      // 
      // FAVORITES ROUTES (Favorite: userId + wordId pairs)
      // 
      case AppRoutes.favorites:
        // From WordService.getAllFavorites(token)
        // Shows list of Favorite entries with wordId + userId
        return _slideRoute(const FavoritesScreen(), settings);

      // 
      // PROFILE ROUTES (User model from UserService)
      // 
      case AppRoutes.profile:
        // User from UserService.getProfile(token)
        // Shows: userId, email, firstName, lastName, profileURL, etc.
        return _slideRoute(const ProfileScreen(), settings);

      case AppRoutes.editProfile:
        // Update via UserService.updateProfile()
        return _slideRoute(const EditProfileScreen(), settings);

      case AppRoutes.changeLanguage:
        return _slideRoute(const ChangeLanguageScreen(), settings);

      case AppRoutes.historyAll:
        // All contributions: WordRequest + CorrectionRequest
        // From RequestService
        return _slideRoute(const HistoryAllScreen(), settings);

      case AppRoutes.historyNewWords:
        // WordRequest entries only
        // From RequestService
        return _slideRoute(const HistoryNewWordsScreen(), settings);

      case AppRoutes.historyCorrections:
        // CorrectionRequest entries only
        // From RequestService
        return _slideRoute(const HistoryCorrectionScreen(), settings);

      case AppRoutes.changePassword:
        return _slideRoute(const ChangePasswordScreen(), settings);

      case AppRoutes.termsAndConditions:
        return _slideRoute(const TermsAndConditionsScreen(), settings);

      // 
      // SUBSCRIPTION ROUTES (PaymentModel from PaymentService)
      // 
      case AppRoutes.subscriptionPlans:
        return _slideRoute(const SubscriptionPlansScreen(), settings);

      case AppRoutes.choosePlan:
        final planId = args[RouteParams.planId] as String? ?? '';

        return _slideRoute(ChoosePlanScreen(planId: planId), settings);

      case AppRoutes.confirmPlan:
        // PaymentModel from PaymentService.generateBakongQR(amount)
        // Contains: paymentId, qrString, md5Hash, status, amount, billNumber
        final planId = args[RouteParams.planId] as String? ?? '';
        final planName = args[RouteParams.planName] as String? ?? '';
        final planPrice = args[RouteParams.planPrice] as String? ?? '';
        final amount = args[RouteParams.paymentAmount] as double?;

        return _slideRoute(
          ConfirmPlanScreen(
            planId: planId,
            planName: planName,
            planPrice: planPrice,
            amount: amount,
          ),
          settings,
        );

      case AppRoutes.subscriptionSuccess:
        // After PaymentModel status is processed via PaymentService.checkStatus()
        final planName = args[RouteParams.planName] as String? ?? '';

        return _scaleRoute(
          SubscriptionSuccessScreen(planName: planName),
          settings,
        );

      // 
      // DEFAULT - 404 ROUTE
      // 
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: Center(child: Text('Route not found: ${settings.name}')),
          ),
          settings: settings,
        );
    }
  }

  // 
  // ROUTE ANIMATIONS
  // 

  /// Fade transition animation (300ms)
  /// Used for: Onboarding screens, language selection
  static PageRoute<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (_, animation, __) =>
          FadeTransition(opacity: animation, child: page),
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Slide transition animation from right (400ms)
  /// Used for: Form screens, navigation screens
  static PageRoute<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Scale transition animation from center (300ms)
  /// Used for: Success/confirmation screens, dialogs
  static PageRoute<dynamic> _scaleRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (_, animation, __) =>
          ScaleTransition(scale: animation, child: page),
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

///////
// TODO: PLACEHOLDER SCREENS - Replace with actual screen later
///////

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Onboarding 1')));
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Onboarding 2')));
}

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Onboarding 3')));
}

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Choose Language')));
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Welcome')));
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Login')));
}

class SignupScreen1 extends StatelessWidget {
  const SignupScreen1({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Signup 1')));
}

class SignupScreen2 extends StatelessWidget {
  const SignupScreen2({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Signup 2')));
}

class SignupScreen3 extends StatelessWidget {
  const SignupScreen3({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Signup 3')));
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Forgot Password')));
}

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Reset Password for $email')));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Home - WordTranslation List')));
}

class WordDetailScreen extends StatelessWidget {
  final int wordId;
  final String? englishWord;
  final String? khmerWord;
  final String? frenchWord;
  final String? definition;
  final String? example;
  final String? imageURL;
  final String? reference;

  const WordDetailScreen({
    super.key,
    required this.wordId,
    this.englishWord,
    this.khmerWord,
    this.frenchWord,
    this.definition,
    this.example,
    this.imageURL,
    this.reference,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Word Detail')),
    body: Center(child: Text('Word #$wordId: $englishWord')),
  );
}

class SearchResultsScreen extends StatelessWidget {
  final String query;
  final String? category;

  const SearchResultsScreen({super.key, required this.query, this.category});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Search: $query')),
    body: Center(child: Text('Results for $query')),
  );
}

class ContributionGuidelineScreen extends StatelessWidget {
  const ContributionGuidelineScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Guidelines')),
    body: const Center(child: Text('Contribution Guidelines')),
  );
}

class SubmitWordRequestScreen extends StatelessWidget {
  const SubmitWordRequestScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New Word')),
    body: const Center(child: Text('Submit WordRequest')),
  );
}

class SubmitCorrectionScreen extends StatelessWidget {
  final int? wordId;
  const SubmitCorrectionScreen({super.key, this.wordId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Correct Word')),
    body: Center(child: Text('Correct word #$wordId')),
  );
}

class ContributionConfirmationScreen extends StatelessWidget {
  final String type;
  final int? wordRequestId;
  final int? correctionId;

  const ContributionConfirmationScreen({
    super.key,
    required this.type,
    this.wordRequestId,
    this.correctionId,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Confirmation')),
    body: Center(child: Text('$type Confirmed')),
  );
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Favorites')),
    body: const Center(child: Text('Favorite List')),
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile')),
    body: const Center(child: Text('User Profile')),
  );
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Edit Profile')),
    body: const Center(child: Text('Edit User Info')),
  );
}

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Language')),
    body: const Center(child: Text('Change Language')),
  );
}

class HistoryAllScreen extends StatelessWidget {
  const HistoryAllScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('All Contributions')),
    body: const Center(child: Text('WordRequest + CorrectionRequest')),
  );
}

class HistoryNewWordsScreen extends StatelessWidget {
  const HistoryNewWordsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New Words')),
    body: const Center(child: Text('WordRequest List')),
  );
}

class HistoryCorrectionScreen extends StatelessWidget {
  const HistoryCorrectionScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Corrections')),
    body: const Center(child: Text('CorrectionRequest List')),
  );
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Change Password')),
    body: const Center(child: Text('Password Change Form')),
  );
}

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Terms & Conditions')),
    body: const Center(child: Text('T&C Content')),
  );
}

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Plans')),
    body: const Center(child: Text('Subscription Plans')),
  );
}

class ChoosePlanScreen extends StatelessWidget {
  final String planId;
  const ChoosePlanScreen({super.key, required this.planId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Choose Plan')),
    body: Center(child: Text('Plan: $planId')),
  );
}

class ConfirmPlanScreen extends StatelessWidget {
  final String planId;
  final String planName;
  final String planPrice;
  final double? amount;

  const ConfirmPlanScreen({
    super.key,
    required this.planId,
    required this.planName,
    required this.planPrice,
    this.amount,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Confirm')),
    body: Center(child: Text('PaymentModel: $planName at $planPrice')),
  );
}

class SubscriptionSuccessScreen extends StatelessWidget {
  final String planName;
  const SubscriptionSuccessScreen({super.key, required this.planName});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Success')),
    body: Center(child: Text('Welcome to $planName')),
  );
}
