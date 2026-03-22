import 'package:domra_tech/model/word_translation.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static void shareWord(WordTranslation word) {
    final url = "https://api.domratech.store/api/share/${word.wordId}";

    Share.share(url);
  }
}
