/// Main routes class containing all route definitions
class AppRoutes {
  AppRoutes._(); // Prevent instantiation

  // 
  // ONBOARDING ROUTES
  // 
  /// First onboarding screen - Welcome to Domra
  static const String onboarding1 = '/onboarding1';

  /// Second onboarding screen - Features overview
  static const String onboarding2 = '/onboarding2';

  /// Third onboarding screen - Benefits/Conclusion
  static const String onboarding3 = '/onboarding3';

  // 
  // AUTHENTICATION ROUTES
  // 
  /// Language selection screen before authentication
  static const String chooseLanguage = '/choose-language';

  /// Welcome screen - First authentication screen
  static const String welcome = '/welcome';

  /// Login screen
  static const String login = '/login';

  /// Sign up screen - Step 1 (Email/Password)
  static const String signup1 = '/signup1';

  /// Sign up screen - Step 2 (Profile Info)
  static const String signup2 = '/signup2';

  /// Sign up screen - Step 3 (Verification)
  static const String signup3 = '/signup3';

  /// Forgot password screen
  static const String forgotPassword = '/forgot-password';

  /// Reset password screen
  static const String resetPassword = '/reset-password';

  // 
  // HOME & MAIN APP ROUTES
  // 
  /// Main home screen with word dictionary - Uses WordTranslation
  static const String home = '/home';

  /// Word detail screen - Shows WordTranslation with full details
  static const String wordDetail = '/word-detail';

  /// Search results screen - Search WordTranslation
  static const String searchResults = '/search-results';

  // 
  // CONTRIBUTION ROUTES
  // 
  /// Contribution guidelines screen
  static const String contributionGuideline = '/contribution-guideline';

  /// Form to submit a new WordRequest
  static const String submitWordRequest = '/submit-word-request';

  /// Form to submit a CorrectionRequest
  static const String submitCorrection = '/submit-correction';

  /// Confirmation screen after submitting WordRequest or CorrectionRequest
  static const String contributionConfirmation = '/contribution-confirmation';

  // 
  // FAVORITE ROUTES
  // 
  /// Favorites screen - List of Favorite entries (wordId + userId)
  static const String favorites = '/favorites';

  // 
  // PROFILE ROUTES
  // 
  /// Main profile screen - Shows User information
  static const String profile = '/profile';

  /// Edit profile screen - Update User info
  static const String editProfile = '/edit-profile';

  /// Change language screen
  static const String changeLanguage = '/change-language';

  /// History/Contributions history screen - View all WordRequest + CorrectionRequest
  static const String historyAll = '/history-all';

  /// History screen - New words contributed (WordRequest)
  static const String historyNewWords = '/history-new-words';

  /// History screen - Word corrections contributed (CorrectionRequest)
  static const String historyCorrections = '/history-corrections';

  /// Change password screen
  static const String changePassword = '/change-password';

  /// Terms and conditions screen
  static const String termsAndConditions = '/terms-and-conditions';

  // 
  // SUBSCRIPTION ROUTES
  // 
  /// Subscription plans overview screen
  static const String subscriptionPlans = '/subscription-plans';

  /// Choose subscription plan screen
  static const String choosePlan = '/choose-plan';

  /// Confirm subscription plan screen - Uses PaymentModel
  static const String confirmPlan = '/confirm-plan';

  /// Subscription successful screen - After PaymentModel processed
  static const String subscriptionSuccess = '/subscription-success';
}
