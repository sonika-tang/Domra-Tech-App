import 'package:domra_tech/firebase_options.dart';
import 'package:domra_tech/state/provider/auth_provider.dart';
import 'package:domra_tech/state/provider/language_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app.dart';

import 'service/auth_service.dart';
import 'service/user_service.dart';
import 'service/word_service.dart';
import 'service/request_service.dart';

import 'package:domra_tech/data/repo/word_repository.dart';

import 'state/models/contribution_state.dart';
import 'state/models/favorite_state.dart';
import 'state/models/user_state.dart';

import 'package:domra_tech/ui/screens/home/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Shared HTTP client
  final httpClient = http.Client();

  // Services
  final authService = AuthService(httpClient);
  final userService = UserService(httpClient);
  final wordService = WordService(httpClient);
  final requestService = RequestService(httpClient);

  // Repositories
  final wordRepository = WordRepository(wordService);

  runApp(
    MultiProvider(
      providers: [
        /// Language / Localization
        ChangeNotifierProvider(create: (_) => LocaleProvider()),

        /// Authentication
        ChangeNotifierProvider(create: (_) => AuthProvider(authService)),

        /// User profile
        ChangeNotifierProvider(create: (_) => UserNotifier(userService: userService)),

        /// Contribution
        ChangeNotifierProvider(create: (_) => ContributionNotifier(requestService)),

        /// Favorites
        ChangeNotifierProvider(create: (_) => FavoriteNotifier(wordService)),

        /// Home words (recent / search / etc.)
        ChangeNotifierProvider(create: (_) => HomeViewModel(wordRepository)..fetchRecentWords()),
      ],
      child: const DomraTech(),
    ),
  );
}
