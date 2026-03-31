import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/service/word_share_service.dart';
import 'package:flutter/material.dart';

class WordDetailViewModel extends ChangeNotifier {
  final WordTranslation word;

  WordDetailViewModel(this.word);

  void shareWord() {
    ShareService.shareWord(word);
  }
}
