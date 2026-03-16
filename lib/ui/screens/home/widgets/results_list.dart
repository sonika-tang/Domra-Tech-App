import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/ui/screens/home/home_view_model.dart';
import 'package:domra_tech/ui/screens/home/word_detail_screen/word_detail_screen.dart';
import 'package:domra_tech/ui/widgets/displays/word_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordList extends StatefulWidget {
  final int? categoryIndex; // Optional: filter by category
  const WordList({super.key, this.categoryIndex});

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  final Set<int> _favoriteWordIds = {};

  void _toggleFavorite(int wordId) {
    setState(() {
      if (_favoriteWordIds.contains(wordId)) {
        _favoriteWordIds.remove(wordId);
      } else {
        _favoriteWordIds.add(wordId);
      }
    });
  }

  void _onClickWord(WordTranslation word) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WordDetailScreen(word: word)));
  }

  void _onShareWord(WordTranslation word) {
    debugPrint("Share: ${word.englishWord}");
    // Implement share functionality here
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final words = viewModel.words;

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (words.isEmpty) {
      return const Center(child: Text("No words found."));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: words.length > 10 ? 10 : words.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final word = words[index];
        final isFavorite = _favoriteWordIds.contains(word.wordId);

        return WordCard(
          wordTranslation: word,
          isFavorite: isFavorite,
          onClick: () => _onClickWord(word),
          onFavorite: () => _toggleFavorite(word.wordId),
          onShare: () => _onShareWord(word),
        );
      },
    );
  }
}
