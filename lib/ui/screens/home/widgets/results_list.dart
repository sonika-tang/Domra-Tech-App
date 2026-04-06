import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/service/word_share_service.dart';
import 'package:domra_tech/ui/screens/home/home_view_model.dart';
import 'package:domra_tech/ui/screens/home/word_detail_screen/word_detail_screen.dart';
import 'package:domra_tech/ui/widgets/displays/word_card.dart';
import 'package:domra_tech/state/models/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class WordList extends StatelessWidget {
  final int? categoryIndex;

  const WordList({super.key, this.categoryIndex});

  Future<String?> _getToken() async {
    return await const FlutterSecureStorage().read(key: 'jwt');
  }

  void _onClickWord(BuildContext context, WordTranslation word) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => WordDetailScreen(word: word)));
  }

  void _onShareWord(WordTranslation word) {
    debugPrint("Share: ${word.englishWord}");
    ShareService.shareWord(word);
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

    return Consumer<FavoriteNotifier>(
      builder: (context, favoriteNotifier, _) {
        final favorites = favoriteNotifier.state.favorites;

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: words.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final word = words[index];
            final isFavorite = favorites.any((fav) => fav.wordId == word.wordId);

            return WordCard(
              wordTranslation: word,
              isFavorite: isFavorite,
              onClick: () => _onClickWord(context, word),
              onFavorite: () async {
                final token = await _getToken();
                if (token != null) {
                  // Toggle favorite in notifier
                  await favoriteNotifier.toggleFavorite(word, token);
                  // No local state needed; UI rebuilds via Consumer
                }
              },
              onShare: () => _onShareWord(word),
            );
          },
        );
      },
    );
  }
}
