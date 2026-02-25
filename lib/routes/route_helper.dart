import 'package:domra_tech/routes/app_routes.dart';

/// Helper methods for route analysis and categorization
class RouteHelper {
  RouteHelper._(); // Prevent instantiation

  /// Check if a route requires authentication
  /// Returns true for protected routes
  static bool requiresAuth(String routeName) {
    const publicRoutes = [
      AppRoutes.onboarding1,
      AppRoutes.onboarding2,
      AppRoutes.onboarding3,
      AppRoutes.chooseLanguage,
      AppRoutes.welcome,
      AppRoutes.login,
      AppRoutes.signup1,
      AppRoutes.signup2,
      AppRoutes.signup3,
      AppRoutes.forgotPassword,
      AppRoutes.resetPassword,
    ];
    return !publicRoutes.contains(routeName);
  }

  /// Get user-friendly route name for display/logging
  static String getRouteName(String routeName) {
    final names = {
      AppRoutes.onboarding1: 'Onboarding 1',
      AppRoutes.onboarding2: 'Onboarding 2',
      AppRoutes.onboarding3: 'Onboarding 3',
      AppRoutes.chooseLanguage: 'Choose Language',
      AppRoutes.welcome: 'Welcome',
      AppRoutes.login: 'Login',
      AppRoutes.signup1: 'Sign Up - Step 1',
      AppRoutes.signup2: 'Sign Up - Step 2',
      AppRoutes.signup3: 'Sign Up - Step 3',
      AppRoutes.forgotPassword: 'Forgot Password',
      AppRoutes.resetPassword: 'Reset Password',
      AppRoutes.home: 'Home',
      AppRoutes.wordDetail: 'Word Detail',
      AppRoutes.searchResults: 'Search Results',
      AppRoutes.contributionGuideline: 'Contribution Guideline',
      AppRoutes.submitWordRequest: 'Submit Word Request',
      AppRoutes.submitCorrection: 'Submit Correction',
      AppRoutes.contributionConfirmation: 'Contribution Confirmation',
      AppRoutes.favorites: 'Favorites',
      AppRoutes.profile: 'Profile',
      AppRoutes.editProfile: 'Edit Profile',
      AppRoutes.changeLanguage: 'Change Language',
      AppRoutes.historyAll: 'History - All',
      AppRoutes.historyNewWords: 'History - New Words',
      AppRoutes.historyCorrections: 'History - Corrections',
      AppRoutes.changePassword: 'Change Password',
      AppRoutes.termsAndConditions: 'Terms & Conditions',
      AppRoutes.subscriptionPlans: 'Subscription Plans',
      AppRoutes.choosePlan: 'Choose Plan',
      AppRoutes.confirmPlan: 'Confirm Plan',
      AppRoutes.subscriptionSuccess: 'Subscription Success',
    };
    return names[routeName] ?? 'Unknown Route';
  }

  /// Get route category for analytics and organization
  static String getRouteCategory(String routeName) {
    if (routeName.contains('onboarding')) return 'onboarding';
    if (routeName.contains('language') ||
        routeName.contains('welcome') ||
        routeName.contains('login') ||
        routeName.contains('signup') ||
        routeName.contains('password')) {
      return 'authentication';
    }
    if (routeName.contains('home') ||
        routeName.contains('word') ||
        routeName.contains('search')) {
      return 'browsing';
    }
    if (routeName.contains('contribution') ||
        routeName.contains('submit') ||
        routeName.contains('correction')) {
      return 'contributions';
    }
    if (routeName.contains('favorite')) return 'favorites';
    if (routeName.contains('profile') ||
        routeName.contains('edit') ||
        routeName.contains('history') ||
        routeName.contains('password') ||
        routeName.contains('terms')) {
      return 'profile';
    }
    if (routeName.contains('subscription') || routeName.contains('plan')) {
      return 'subscription';
    }
    return 'other';
  }

  /// Get all authentication routes
  static List<String> getAuthRoutes() {
    return [
      AppRoutes.chooseLanguage,
      AppRoutes.welcome,
      AppRoutes.login,
      AppRoutes.signup1,
      AppRoutes.signup2,
      AppRoutes.signup3,
      AppRoutes.forgotPassword,
      AppRoutes.resetPassword,
    ];
  }

  /// Get all onboarding routes
  static List<String> getOnboardingRoutes() {
    return [
      AppRoutes.onboarding1,
      AppRoutes.onboarding2,
      AppRoutes.onboarding3,
    ];
  }

  /// Get all protected routes (require authentication)
  static List<String> getProtectedRoutes() {
    return [
      AppRoutes.home,
      AppRoutes.wordDetail,
      AppRoutes.searchResults,
      AppRoutes.contributionGuideline,
      AppRoutes.submitWordRequest,
      AppRoutes.submitCorrection,
      AppRoutes.contributionConfirmation,
      AppRoutes.favorites,
      AppRoutes.profile,
      AppRoutes.editProfile,
      AppRoutes.changeLanguage,
      AppRoutes.historyAll,
      AppRoutes.historyNewWords,
      AppRoutes.historyCorrections,
      AppRoutes.changePassword,
      AppRoutes.termsAndConditions,
      AppRoutes.subscriptionPlans,
      AppRoutes.choosePlan,
      AppRoutes.confirmPlan,
      AppRoutes.subscriptionSuccess,
    ];
  }
}
