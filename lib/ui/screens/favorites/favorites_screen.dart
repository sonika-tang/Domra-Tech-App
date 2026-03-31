import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:domra_tech/model/word_translation.dart';
import 'package:domra_tech/service/word_share_service.dart';
import 'package:domra_tech/ui/screens/home/word_detail_screen/word_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_text_style.dart';
import '../../../state/models/favorite_state.dart';
import '../../widgets/displays/word_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final favoriteNotifier = context.read<FavoriteNotifier>();
      final token = await _storage.read(key: 'jwt');

      if (token != null && token.isNotEmpty) {
        await favoriteNotifier.fetchFavorites(token);
      }
    });
  }

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt');
  }

  void _onShareWord(WordTranslation word) {
    debugPrint("Share: ${word.englishWord}");
    ShareService.shareWord(word);
  }

  void _onClickWord(BuildContext context, WordTranslation word) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => WordDetailScreen(word: word)));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.navFavorite,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<FavoriteNotifier>(
        builder: (context, favoriteNotifier, child) {
          final state = favoriteNotifier.state;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  state.error!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                ),
              ),
            );
          }

          if (state.favorites.isEmpty) {
            return Center(child: Text('No favorites yet', style: theme.textTheme.bodyMedium));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.s16),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final word = state.favorites[index];
              final favoriteNotifier = context.read<FavoriteNotifier>();

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.s12),
                child: WordCard(
                  wordTranslation: word,
                  isFavorite: favoriteNotifier.isFavorite(word.wordId),
                  onClick: () => _onClickWord(context, word),
                  onFavorite: () async {
                    final token = await _getToken();
                    if (token != null) {
                      await favoriteNotifier.toggleFavorite(word, token);
                    }
                  },
                  onShare: () => _onShareWord(word),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
