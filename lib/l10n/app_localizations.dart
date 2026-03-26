import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km'),
  ];

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Domra'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubTitle1.
  ///
  /// In en, this message translates to:
  /// **'Your trilingual technical dictionary for Cambodia.'**
  String get onboardingSubTitle1;

  /// No description provided for @title2.
  ///
  /// In en, this message translates to:
  /// **'Find Accurate Technical Terms Fast'**
  String get title2;

  /// No description provided for @subTitle2.
  ///
  /// In en, this message translates to:
  /// **'Search across Khmer – English – French with ease.'**
  String get subTitle2;

  /// No description provided for @title3.
  ///
  /// In en, this message translates to:
  /// **'Contribute To Khmer Technical Vocabulary'**
  String get title3;

  /// No description provided for @subTitle3.
  ///
  /// In en, this message translates to:
  /// **'Add new terms or request corrections to improve the community.'**
  String get subTitle3;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStart.
  ///
  /// In en, this message translates to:
  /// **'Get start'**
  String get getStart;

  /// No description provided for @welcomePage.
  ///
  /// In en, this message translates to:
  /// **'Welcome Page'**
  String get welcomePage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get guest;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email'**
  String get enterEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your Password'**
  String get enterPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmailFormat;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @termsAndConditionsLink.
  ///
  /// In en, this message translates to:
  /// **'Terms of Condition'**
  String get termsAndConditionsLink;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'By logging in you agree to our'**
  String get agreeToTerms;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have an Account?'**
  String get dontHaveAccount;

  /// No description provided for @continueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get continueWith;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @setupAccount.
  ///
  /// In en, this message translates to:
  /// **'Set up Account'**
  String get setupAccount;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterLastName;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get gender;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dob;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get chooseDate;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @setupPassword.
  ///
  /// In en, this message translates to:
  /// **'Set up Password'**
  String get setupPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree with'**
  String get agree;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Send verification'**
  String get verification;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @setPassword.
  ///
  /// In en, this message translates to:
  /// **'Set Password'**
  String get setPassword;

  /// No description provided for @newPass.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPass;

  /// No description provided for @enterNewPass.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPass;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search terms'**
  String get search;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navContribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get navContribute;

  /// No description provided for @navFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get navFavorite;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @wordDetail.
  ///
  /// In en, this message translates to:
  /// **'Word Detail'**
  String get wordDetail;

  /// No description provided for @definition.
  ///
  /// In en, this message translates to:
  /// **'Definition'**
  String get definition;

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get example;

  /// No description provided for @noExample.
  ///
  /// In en, this message translates to:
  /// **'No example'**
  String get noExample;

  /// No description provided for @picture.
  ///
  /// In en, this message translates to:
  /// **'Picture'**
  String get picture;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @newTermForm.
  ///
  /// In en, this message translates to:
  /// **'New Term Form'**
  String get newTermForm;

  /// No description provided for @englishWord.
  ///
  /// In en, this message translates to:
  /// **'English Word'**
  String get englishWord;

  /// No description provided for @khmerWord.
  ///
  /// In en, this message translates to:
  /// **'Khmer Word'**
  String get khmerWord;

  /// No description provided for @frenchWord.
  ///
  /// In en, this message translates to:
  /// **'French Word'**
  String get frenchWord;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @wordRequest.
  ///
  /// In en, this message translates to:
  /// **'Word Request'**
  String get wordRequest;

  /// No description provided for @requestConfirm.
  ///
  /// In en, this message translates to:
  /// **'Request submitted successfully!'**
  String get requestConfirm;

  /// No description provided for @confirmDesc.
  ///
  /// In en, this message translates to:
  /// **'Our team will review your contribution soon.'**
  String get confirmDesc;

  /// No description provided for @viewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// No description provided for @returnHome.
  ///
  /// In en, this message translates to:
  /// **'Return Home'**
  String get returnHome;

  /// No description provided for @improveTranslation.
  ///
  /// In en, this message translates to:
  /// **'Improve Translation'**
  String get improveTranslation;

  /// No description provided for @guideline.
  ///
  /// In en, this message translates to:
  /// **'Guideline'**
  String get guideline;

  /// No description provided for @requestNow.
  ///
  /// In en, this message translates to:
  /// **'Request now'**
  String get requestNow;

  /// No description provided for @improveNow.
  ///
  /// In en, this message translates to:
  /// **'Improve now'**
  String get improveNow;

  /// No description provided for @g1Step1.
  ///
  /// In en, this message translates to:
  /// **'STEP01 - Enter the Term'**
  String get g1Step1;

  /// No description provided for @g1Step1Sub.
  ///
  /// In en, this message translates to:
  /// **'Type the new term you want to request in English, Khmer, or French.'**
  String get g1Step1Sub;

  /// No description provided for @g1Step2.
  ///
  /// In en, this message translates to:
  /// **'STEP02 - Add Meaning (Optional)'**
  String get g1Step2;

  /// No description provided for @g1Step2Sub.
  ///
  /// In en, this message translates to:
  /// **'Provide a short explanation or context to help reviewers understand your request.'**
  String get g1Step2Sub;

  /// No description provided for @g1Step3.
  ///
  /// In en, this message translates to:
  /// **'STEP03 - Submit Request'**
  String get g1Step3;

  /// No description provided for @g1Step3Sub.
  ///
  /// In en, this message translates to:
  /// **'Tap Submit — your request will be reviewed and added if approved.'**
  String get g1Step3Sub;

  /// No description provided for @g2Step1.
  ///
  /// In en, this message translates to:
  /// **'STEP01 - Search the Translation'**
  String get g2Step1;

  /// No description provided for @g2Step1Sub.
  ///
  /// In en, this message translates to:
  /// **'Navigate to the home page and search your preferred word.'**
  String get g2Step1Sub;

  /// No description provided for @g2Step2.
  ///
  /// In en, this message translates to:
  /// **'STEP02 - Suggest a Better Version'**
  String get g2Step2;

  /// No description provided for @g2Step2Sub.
  ///
  /// In en, this message translates to:
  /// **'Enter your corrected term or improved definition with a short explanation.'**
  String get g2Step2Sub;

  /// No description provided for @g2Step3.
  ///
  /// In en, this message translates to:
  /// **'STEP03 - Submit Your Improvement'**
  String get g2Step3;

  /// No description provided for @g2Step3Sub.
  ///
  /// In en, this message translates to:
  /// **'Tap Submit Update and our team will verify and apply the improvement.'**
  String get g2Step3Sub;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @saveChange.
  ///
  /// In en, this message translates to:
  /// **'Save change'**
  String get saveChange;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @enterCurrentPass.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get enterCurrentPass;

  /// No description provided for @contributionHistory.
  ///
  /// In en, this message translates to:
  /// **'Contribution History'**
  String get contributionHistory;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @newWord.
  ///
  /// In en, this message translates to:
  /// **'New Word'**
  String get newWord;

  /// No description provided for @wordCorrection.
  ///
  /// In en, this message translates to:
  /// **'Word Correction'**
  String get wordCorrection;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language to use in Domra Tech'**
  String get description;

  /// No description provided for @termOfCondition.
  ///
  /// In en, this message translates to:
  /// **'Term of condition'**
  String get termOfCondition;

  /// No description provided for @subscriptionPlans.
  ///
  /// In en, this message translates to:
  /// **'Subscription Plans'**
  String get subscriptionPlans;

  /// No description provided for @browsePlans.
  ///
  /// In en, this message translates to:
  /// **'Browse our subscription plans'**
  String get browsePlans;

  /// No description provided for @myPlans.
  ///
  /// In en, this message translates to:
  /// **'My subscription'**
  String get myPlans;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @subscribeAt.
  ///
  /// In en, this message translates to:
  /// **'Subscribed at'**
  String get subscribeAt;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @newPlan.
  ///
  /// In en, this message translates to:
  /// **'New Subscription'**
  String get newPlan;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @priceDesc.
  ///
  /// In en, this message translates to:
  /// **'Get unlimited access to all features'**
  String get priceDesc;

  /// No description provided for @whatInclude.
  ///
  /// In en, this message translates to:
  /// **'What’s included'**
  String get whatInclude;

  /// No description provided for @feature1.
  ///
  /// In en, this message translates to:
  /// **'Get unlimited access to all features'**
  String get feature1;

  /// No description provided for @feature2.
  ///
  /// In en, this message translates to:
  /// **'Get the offline Mode'**
  String get feature2;

  /// No description provided for @feature3.
  ///
  /// In en, this message translates to:
  /// **'Use app without Ads'**
  String get feature3;

  /// No description provided for @subscriptionSummary.
  ///
  /// In en, this message translates to:
  /// **'Subscription summary'**
  String get subscriptionSummary;

  /// No description provided for @paymentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Click confirm and pay through Bakong'**
  String get paymentConfirm;

  /// No description provided for @confirmAndPay.
  ///
  /// In en, this message translates to:
  /// **'Confirm and Pay'**
  String get confirmAndPay;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccess;

  /// No description provided for @paymentThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for subscription.'**
  String get paymentThanks;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @newestToOldest.
  ///
  /// In en, this message translates to:
  /// **'Newest to Oldest'**
  String get newestToOldest;

  /// No description provided for @oldestToNewest.
  ///
  /// In en, this message translates to:
  /// **'Oldest to Newest'**
  String get oldestToNewest;

  /// No description provided for @aToZ.
  ///
  /// In en, this message translates to:
  /// **'A to Z'**
  String get aToZ;

  /// No description provided for @zToA.
  ///
  /// In en, this message translates to:
  /// **'Z to A'**
  String get zToA;

  /// No description provided for @noContributionsYet.
  ///
  /// In en, this message translates to:
  /// **'No contributions yet'**
  String get noContributionsYet;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted {date}'**
  String submitted(String date);

  /// No description provided for @languageChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully'**
  String get languageChangedSuccessfully;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// No description provided for @selectNewImage.
  ///
  /// In en, this message translates to:
  /// **'Select a new image for your profile.'**
  String get selectNewImage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @profilePictureUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile picture updated'**
  String get profilePictureUpdated;

  /// No description provided for @simulateGalleryPick.
  ///
  /// In en, this message translates to:
  /// **'Simulate Gallery Pick'**
  String get simulateGalleryPick;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @pleaseEnterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get pleaseEnterCurrentPassword;

  /// No description provided for @pleaseEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get pleaseEnterNewPassword;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordHint;

  /// No description provided for @enterNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPasswordHint;

  /// No description provided for @enterConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterConfirmPasswordHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
