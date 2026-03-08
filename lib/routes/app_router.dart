/// Main router implementation for the Domra app

import 'package:domra_tech/routes/route_params.dart';
import 'package:domra_tech/ui/screens/authentication/choose_language_screen.dart';
import 'package:domra_tech/ui/screens/authentication/forgot_password_screen.dart';
import 'package:domra_tech/ui/screens/authentication/login_screen.dart';
import 'package:domra_tech/ui/screens/authentication/reset_password_screen.dart';
import 'package:domra_tech/ui/screens/authentication/signup_1_screen.dart';
import 'package:domra_tech/ui/screens/authentication/signup_2_screen.dart';
import 'package:domra_tech/ui/screens/authentication/signup_3_screen.dart';
import 'package:domra_tech/ui/screens/authentication/welcome_screen.dart';
import 'package:domra_tech/ui/screens/contributions/contribution_confirmation_screen.dart';
import 'package:domra_tech/ui/screens/contributions/submit_correction_screen.dart';
import 'package:domra_tech/ui/screens/contributions/submit_word_request_screen.dart';
import 'package:domra_tech/ui/screens/home/search_result_screen.dart';
import 'package:domra_tech/ui/screens/home/word_detail_screen.dart';
import 'package:domra_tech/ui/screens/main_shell.dart';
import 'package:domra_tech/ui/screens/onboarding/onboarding_1_screen.dart';
import 'package:domra_tech/ui/screens/onboarding/onboarding_2_screen.dart';
import 'package:domra_tech/ui/screens/onboarding/onboarding_3_screen.dart';
import 'package:domra_tech/ui/screens/profile/change_language_screen.dart';
import 'package:domra_tech/ui/screens/profile/change_password_screen.dart';
import 'package:domra_tech/ui/screens/profile/edit_profile_screen.dart';
import 'package:domra_tech/ui/screens/profile/history_all_screen.dart';
import 'package:domra_tech/ui/screens/profile/history_corrections_screen.dart';
import 'package:domra_tech/ui/screens/profile/history_new_words_screen.dart';
import 'package:domra_tech/ui/screens/profile/terms_and_conditions_screen.dart';
import 'package:domra_tech/ui/screens/subscription/choose_plan_screen.dart';
import 'package:domra_tech/ui/screens/subscription/confirm_plan_screen.dart';
import 'package:domra_tech/ui/screens/subscription/subscription_plans_screen.dart';
import 'package:domra_tech/ui/screens/subscription/subscription_success_screen.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

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
        return _fadeRoute(const MainShell(initialIndex: 0), settings);

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
        // Show Contribution guidelines inside the main shell with bottom nav
        return _fadeRoute(const MainShell(initialIndex: 1), settings);

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
        // Favorites list shown as the third tab in the main shell
        return _fadeRoute(const MainShell(initialIndex: 2), settings);

      //
      // PROFILE ROUTES (User model from UserService)
      //
      case AppRoutes.profile:
        // Profile screen shown as the fourth tab in the main shell
        return _fadeRoute(const MainShell(initialIndex: 3), settings);

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
