import 'package:domra_tech/state/models/auth_state.dart';
import 'package:domra_tech/state/models/contribution_state.dart';
import 'package:domra_tech/state/models/favorite_state.dart';
import 'package:domra_tech/state/models/payment_state.dart';
import 'package:domra_tech/state/models/user_state.dart';
import 'package:domra_tech/state/models/word_state.dart';
import 'package:provider/provider.dart';

/// Global list of providers for MultiProvider
/// This list is used in main.dart to set up all state notifiers
List<ChangeNotifierProvider> getStateProviders() {
  return [
    /// Authentication provider
    /// Manages: login, register, logout, token refresh
    ChangeNotifierProvider<AuthNotifier>(create: (context) => AuthNotifier()),

    /// Word management provider
    /// Manages: fetch words, search, filter by category
    ChangeNotifierProvider<WordNotifier>(create: (context) => WordNotifier()),

    /// Favorite words provider
    /// Manages: add/remove favorites, fetch favorites list
    ChangeNotifierProvider<FavoriteNotifier>(
      create: (context) => FavoriteNotifier(),
    ),

    /// Contributions provider
    /// Manages: word requests, corrections, submission status
    ChangeNotifierProvider<ContributionNotifier>(
      create: (context) => ContributionNotifier(),
    ),

    /// Payment & subscription provider
    /// Manages: QR generation, payment status, plan selection
    ChangeNotifierProvider<PaymentNotifier>(
      create: (context) => PaymentNotifier(),
    ),

    /// User profile provider
    /// Manages: fetch profile, update profile, password change
    ChangeNotifierProvider<UserNotifier>(create: (context) => UserNotifier()),
  ];
}

/// Helper class to access providers throughout the app
/// Usage: AppProviders.auth(context).login(email, password)
class AppProviders {
  /// Access auth provider
  static AuthNotifier auth(context) =>
      Provider.of<AuthNotifier>(context, listen: false);

  /// Access auth provider with listener
  static AuthNotifier authWatch(context) =>
      Provider.of<AuthNotifier>(context, listen: true);

  /// Access word provider
  static WordNotifier word(context) =>
      Provider.of<WordNotifier>(context, listen: false);

  /// Access word provider with listener
  static WordNotifier wordWatch(context) =>
      Provider.of<WordNotifier>(context, listen: true);

  /// Access favorite provider
  static FavoriteNotifier favorite(context) =>
      Provider.of<FavoriteNotifier>(context, listen: false);

  /// Access favorite provider with listener
  static FavoriteNotifier favoriteWatch(context) =>
      Provider.of<FavoriteNotifier>(context, listen: true);

  /// Access contribution provider
  static ContributionNotifier contribution(context) =>
      Provider.of<ContributionNotifier>(context, listen: false);

  /// Access contribution provider with listener
  static ContributionNotifier contributionWatch(context) =>
      Provider.of<ContributionNotifier>(context, listen: true);

  /// Access payment provider
  static PaymentNotifier payment(context) =>
      Provider.of<PaymentNotifier>(context, listen: false);

  /// Access payment provider with listener
  static PaymentNotifier paymentWatch(context) =>
      Provider.of<PaymentNotifier>(context, listen: true);

  /// Access user provider
  static UserNotifier user(context) =>
      Provider.of<UserNotifier>(context, listen: false);

  /// Access user provider with listener
  static UserNotifier userWatch(context) =>
      Provider.of<UserNotifier>(context, listen: true);
}
