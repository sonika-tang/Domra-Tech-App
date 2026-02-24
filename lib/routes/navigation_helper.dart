/// Navigation helper extension methods on BuildContext.

import 'package:domra_tech/routes/route_params.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

/// Extension methods on BuildContext for convenient navigation
extension NavigationHelper on BuildContext {
  // 
  // NAVIGATION METHODS - Onboarding
  // 

  /// Navigate to first onboarding screen
  void goToOnboarding1() {
    Navigator.pushNamedAndRemoveUntil(
      this,
      AppRoutes.onboarding1,
      (route) => false,
    );
  }

  /// Navigate to second onboarding screen
  void goToOnboarding2() {
    Navigator.pushNamed(this, AppRoutes.onboarding2);
  }

  /// Navigate to third onboarding screen
  void goToOnboarding3() {
    Navigator.pushNamed(this, AppRoutes.onboarding3);
  }

  // 
  // NAVIGATION METHODS - Authentication
  // 

  /// Navigate to language selection screen
  void goToChooseLanguage() {
    Navigator.pushNamedAndRemoveUntil(
      this,
      AppRoutes.chooseLanguage,
      (route) => false,
    );
  }

  /// Navigate to welcome screen
  void goToWelcome() {
    Navigator.pushNamedAndRemoveUntil(
      this,
      AppRoutes.welcome,
      (route) => false,
    );
  }

  /// Navigate to login screen
  void goToLogin() {
    Navigator.pushNamedAndRemoveUntil(this, AppRoutes.login, (route) => false);
  }

  /// Navigate to sign up step 1
  void goToSignup1() {
    Navigator.pushNamed(this, AppRoutes.signup1);
  }

  /// Navigate to sign up step 2
  void goToSignup2() {
    Navigator.pushNamed(this, AppRoutes.signup2);
  }

  /// Navigate to sign up step 3
  void goToSignup3() {
    Navigator.pushNamed(this, AppRoutes.signup3);
  }

  /// Navigate to forgot password screen
  void goToForgotPassword() {
    Navigator.pushNamed(this, AppRoutes.forgotPassword);
  }

  /// Navigate to reset password screen
  /// [email] - User's email for password reset
  void goToResetPassword({required String email}) {
    Navigator.pushNamed(
      this,
      AppRoutes.resetPassword,
      arguments: {RouteParams.email: email},
    );
  }

  // 
  // NAVIGATION METHODS - Main App (WordTranslation)
  // 

  /// Navigate to home screen
  /// [clearStack] - If true, removes all routes below home
  void goToHome({bool clearStack = false}) {
    if (clearStack) {
      Navigator.pushNamedAndRemoveUntil(this, AppRoutes.home, (route) => false);
    } else {
      Navigator.pushNamed(this, AppRoutes.home);
    }
  }

  /// Navigate to word detail screen with WordTranslation data
  /// [wordId] - Required: from WordTranslation.wordId (int)
  void goToWordDetail({
    required int wordId,
    String? englishWord,
    String? khmerWord,
    String? frenchWord,
    String? definition,
    String? example,
    String? imageURL,
    String? reference,
  }) {
    Navigator.pushNamed(
      this,
      AppRoutes.wordDetail,
      arguments: {
        RouteParams.wordId: wordId,
        if (englishWord != null) RouteParams.englishWord: englishWord,
        if (khmerWord != null) RouteParams.khmerWord: khmerWord,
        if (frenchWord != null) RouteParams.frenchWord: frenchWord,
        if (definition != null) RouteParams.definition: definition,
        if (example != null) RouteParams.example: example,
        if (imageURL != null) RouteParams.imageURL: imageURL,
        if (reference != null) RouteParams.reference: reference,
      },
    );
  }

  /// Navigate to search results
  void goToSearchResults({required String query, String? category}) {
    Navigator.pushNamed(
      this,
      AppRoutes.searchResults,
      arguments: {
        RouteParams.searchQuery: query,
        if (category != null) RouteParams.selectedCategory: category,
      },
    );
  }

  // 
  // NAVIGATION METHODS - Contributions (WordRequest & CorrectionRequest)
  // 

  /// Navigate to contribution guidelines
  void goToContributionGuideline() {
    Navigator.pushNamed(this, AppRoutes.contributionGuideline);
  }

  /// Navigate to submit word request form
  /// Creates a new WordRequest via RequestService
  void goToSubmitWordRequest() {
    Navigator.pushNamed(this, AppRoutes.submitWordRequest);
  }

  /// Navigate to submit correction form for a WordTranslation
  /// [wordId] - Optional: WordTranslation.wordId (int) to correct
  void goToSubmitCorrection({int? wordId}) {
    Navigator.pushNamed(
      this,
      AppRoutes.submitCorrection,
      arguments: {if (wordId != null) RouteParams.correctionWordId: wordId},
    );
  }

  /// Navigate to contribution confirmation after WordRequest or CorrectionRequest
  /// [contributionType] - 'word_request' or 'correction'
  /// [wordRequestId] - From WordRequest.wordRequestId (int) if type is 'word_request'
  /// [correctionId] - From CorrectionRequest.correctionId (int) if type is 'correction'
  void goToContributionConfirmation({
    required String contributionType,
    int? wordRequestId,
    int? correctionId,
  }) {
    Navigator.pushNamed(
      this,
      AppRoutes.contributionConfirmation,
      arguments: {
        RouteParams.contributionType: contributionType,
        if (wordRequestId != null) RouteParams.wordRequestId: wordRequestId,
        if (correctionId != null) RouteParams.correctionId: correctionId,
      },
    );
  }

  // 
  // NAVIGATION METHODS - Favorites (Favorite model: userId + wordId)
  // 

  /// Navigate to favorites screen
  /// Shows list of Favorite entries (wordId + userId pairs)
  void goToFavorites() {
    Navigator.pushNamed(this, AppRoutes.favorites);
  }

  // 
  // NAVIGATION METHODS - Profile (User model)
  // 

  /// Navigate to profile screen
  /// Shows User information (userId, email, firstName, lastName, etc.)
  void goToProfile() {
    Navigator.pushNamed(this, AppRoutes.profile);
  }

  /// Navigate to edit profile screen
  /// Updates User via UserService.updateProfile()
  void goToEditProfile() {
    Navigator.pushNamed(this, AppRoutes.editProfile);
  }

  /// Navigate to change language screen
  void goToChangeLanguage() {
    Navigator.pushNamed(this, AppRoutes.changeLanguage);
  }

  /// Navigate to history - all contributions
  /// Shows both WordRequest and CorrectionRequest entries
  void goToHistoryAll() {
    Navigator.pushNamed(this, AppRoutes.historyAll);
  }

  /// Navigate to history - new words contributed
  /// Shows only WordRequest entries from user
  void goToHistoryNewWords() {
    Navigator.pushNamed(this, AppRoutes.historyNewWords);
  }

  /// Navigate to history - corrections contributed
  /// Shows only CorrectionRequest entries from user
  void goToHistoryCorrections() {
    Navigator.pushNamed(this, AppRoutes.historyCorrections);
  }

  /// Navigate to change password screen
  void goToChangePassword() {
    Navigator.pushNamed(this, AppRoutes.changePassword);
  }

  /// Navigate to terms and conditions
  void goToTermsAndConditions() {
    Navigator.pushNamed(this, AppRoutes.termsAndConditions);
  }

  // 
  // NAVIGATION METHODS - Subscription (PaymentModel)
  // 

  /// Navigate to subscription plans
  void goToSubscriptionPlans() {
    Navigator.pushNamed(this, AppRoutes.subscriptionPlans);
  }

  /// Navigate to choose plan screen
  /// [planId] - Plan identifier (String)
  void goToChoosePlan({required String planId}) {
    Navigator.pushNamed(
      this,
      AppRoutes.choosePlan,
      arguments: {RouteParams.planId: planId},
    );
  }

  /// Navigate to confirm plan screen with PaymentModel info
  /// [planId] - Plan identifier (String)
  /// [planName] - Display name (String)
  /// [planPrice] - Price string (String)
  /// [amount] - Payment amount in double for PaymentModel
  void goToConfirmPlan({
    required String planId,
    required String planName,
    required String planPrice,
    double? amount,
  }) {
    Navigator.pushNamed(
      this,
      AppRoutes.confirmPlan,
      arguments: {
        RouteParams.planId: planId,
        RouteParams.planName: planName,
        RouteParams.planPrice: planPrice,
        if (amount != null) RouteParams.paymentAmount: amount,
      },
    );
  }

  /// Navigate to subscription success screen after PaymentModel processed
  /// [planName] - Name of the subscribed plan
  void goToSubscriptionSuccess({required String planName}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      AppRoutes.subscriptionSuccess,
      (route) => route.settings.name == AppRoutes.home,
      arguments: {RouteParams.planName: planName},
    );
  }

  // 
  // UTILITY NAVIGATION METHODS
  // 

  /// Go back to previous screen
  void goBack<T>({T? result}) {
    Navigator.pop(this, result);
  }

  /// Check if can go back
  bool canGoBack() {
    return Navigator.canPop(this);
  }

  /// Navigate to home and clear everything below it
  void goToHomeAndClear() {
    Navigator.pushNamedAndRemoveUntil(this, AppRoutes.home, (route) => false);
  }

  /// Navigate to login and clear everything (logout)
  void logoutAndGoToLogin() {
    Navigator.pushNamedAndRemoveUntil(this, AppRoutes.login, (route) => false);
  }

  /// Replace current screen with new one
  void replaceWith(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }
}
