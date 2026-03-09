import 'package:domra_tech/mockdata/word_translation_mock.dart';
import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/ui/screens/home/word_detail_screen/word_detail_screen.dart';
import 'package:domra_tech/ui/widgets/displays/word_card.dart';
import 'package:flutter/material.dart';

class WordList extends StatefulWidget {
  const WordList({super.key});

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  final List<WordTranslation> words = mockWordTranslations;
  final Set<int> favoriteWordIds = {};

  void _toggleFavorite(int wordId) {
    setState(() {
      if (favoriteWordIds.contains(wordId)) {
        favoriteWordIds.remove(wordId);
      } else {
        favoriteWordIds.add(wordId);
      }
    });
  }

  void _onShare(WordTranslation word) {
    debugPrint("Share: ${word.englishWord}");
    // Later you can use share_plus package
  }

  void _onClick(WordTranslation word) {
    print("Navigating to ${word.englishWord}");
    Navigator.push(context, MaterialPageRoute(builder: (context) => WordDetailScreen(word: word)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: WordCard(
            wordTranslation: word,
            isFavorite: favoriteWordIds.contains(word.wordId),
            onClick: () => _onClick(word),
            onFavorite: () => _toggleFavorite(word.wordId),
            onShare: () => _onShare(word),
          ),
        );
      },
    );
  }
}
