import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

class LanguageService {
  final LanguageIdentifier _identifier = LanguageIdentifier(confidenceThreshold: 0.5);

  Future<String> detect(String text) async {
    final code = await _identifier.identifyLanguage(text);

    if (code == 'und') {
      if (RegExp(r'[ក-៿]').hasMatch(text)) {
        return 'khmer';
      }
      return 'english';
    }

    switch (code) {
      case 'km':
        return 'khmer';
      case 'fr':
        return 'french';
      case 'en':
      default:
        return 'english';
    }
  }
}
