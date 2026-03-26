import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/service/word_share_service.dart';
import 'package:flutter/material.dart';

class WordDetailViewModel extends ChangeNotifier {
  final WordTranslation word;

  WordDetailViewModel(this.word);

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void shareWord() {
    ShareService.shareWord(word);
  }
}
