import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../state/models/favorite_state.dart';
import '../../../state/provider/auth_provider.dart';
import '../../widgets/displays/word_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch favorites once the widget is mounted so we have a valid context.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>();
      final favoriteNotifier = context.read<FavoriteNotifier>();
      final token = await authProvider.getIdToken();
      await favoriteNotifier.fetchFavorites(token);
    });
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
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
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              ),
            );
          }

          if (state.favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet',
                style: theme.textTheme.bodyMedium,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.s16),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final word = state.favorites[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.s12),
                child: WordCard(
                  wordTranslation: word,
                  isFavorite: true,
                  onClick: () {
                    // TODO: Navigate to word detail page when implemented.
                  },
                  onFavorite: () async {
                    final authProvider = context.read<AuthProvider>();
                    final token = await authProvider.getIdToken();
                    await context.read<FavoriteNotifier>().removeFavorite(
                      word.wordId,
                      token,
                    );
                  },
                  onShare: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share feature coming soon'),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
