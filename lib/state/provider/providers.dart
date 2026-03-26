import 'package:domra_tech/state/models/contribution_state.dart';
import 'package:domra_tech/state/models/user_state.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:domra_tech/service/user_service.dart';
import 'package:domra_tech/service/request_service.dart';

/// Global list of providers for MultiProvider
/// This list is used in main.dart to set up all state notifiers
List<ChangeNotifierProvider> getStateProviders() {
  return [
    /// Contributions provider
    /// Manages: word requests, corrections, submission status
    ChangeNotifierProvider<ContributionNotifier>(
      create: (context) => ContributionNotifier(RequestService(http.Client())),
    ),

    /// User profile provider
    /// Manages: fetch profile, update profile, password change
    ChangeNotifierProvider<UserNotifier>(
      create: (context) =>
          UserNotifier(userService: UserService(http.Client())),
    ),
  ];
}

/// Helper class to access providers throughout the app
/// Usage: AppProviders.auth(context).login(email, password)
class AppProviders {
  /// Access contribution provider
  static ContributionNotifier contribution(context) =>
      Provider.of<ContributionNotifier>(context, listen: false);

  /// Access contribution provider with listener
  static ContributionNotifier contributionWatch(context) =>
      Provider.of<ContributionNotifier>(context, listen: true);

  /// Access user provider
  static UserNotifier user(context) =>
      Provider.of<UserNotifier>(context, listen: false);

  /// Access user provider with listener
  static UserNotifier userWatch(context) =>
      Provider.of<UserNotifier>(context, listen: true);
}
