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
import 'state/models/contribution_state.dart';
import 'state/models/favorite_state.dart';
import 'state/models/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(AuthService(http.Client())),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              UserNotifier(userService: UserService(http.Client())),
        ),
        ChangeNotifierProvider(create: (context) => ContributionNotifier()),
        ChangeNotifierProvider(
          create: (context) => FavoriteNotifier(WordService(http.Client())),
        ),
      ],
      child: const DomraTech(),
    ),
  );
}
