import 'dart:ui';
import 'package:share_plus/share_plus.dart';
import '../model/word_translation.dart';

class ShareService {
  static void shareWord(WordTranslation word) {
    final english = word.englishWord ?? "";
    final french = word.frenchWord ?? "";
    final khmer = word.khmerWord;
    final definition = word.definition ?? "No definition available.";
    final example = word.example ?? "";

    final content =
        '''
DOMRA-TECH LEXICON\n
🇬🇧 English: ${english.isNotEmpty ? english : "-"}\n
🇫🇷 French: ${french.isNotEmpty ? french : "-"}\n
🇰🇭 Khmer: $khmer

📖 Definition:
$definition\n

${example.isNotEmpty ? "📝 Example:\n$example\n" : ""}\n

Discover more technical terms with Domra-Tech Trilingual System
''';

    // sharePositionOrigin is required for iOS/iPadOS
    Share.share(content, sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100));
  }
}
