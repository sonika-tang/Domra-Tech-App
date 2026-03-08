import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../state/models/contribution_state.dart';
import 'widgets/history_item.dart';

class HistoryCorrectionScreen extends StatefulWidget {
  const HistoryCorrectionScreen({super.key});

  @override
  State<HistoryCorrectionScreen> createState() =>
      _HistoryCorrectionScreenState();
}

class _HistoryCorrectionScreenState extends State<HistoryCorrectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContributionNotifier>().fetchContributions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.wordCorrection),
        elevation: 0,
        backgroundColor: colorScheme.primary,
      ),
      body: Consumer<ContributionNotifier>(
        builder: (context, contribProvider, child) {
          final corrections = contribProvider.state.corrections;

          if (contribProvider.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (corrections.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    size: 64,
                    color: colorScheme.outline.withValues(alpha: .3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No corrections yet',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: corrections.length,
            itemBuilder: (context, index) {
              final correction = corrections[index];
              final parts = [
                if (correction.correctEnglishWord != null)
                  'EN: ${correction.correctEnglishWord}',
                if (correction.correctKhmerWord != null)
                  'KH: ${correction.correctKhmerWord}',
                if (correction.correctFrenchWord != null)
                  'FR: ${correction.correctFrenchWord}',
              ];
              return HistoryItem(
                title: 'Word ID: ${correction.wordId}',
                description:
                    parts.isNotEmpty ? parts.join('  •  ') : 'Correction submitted',
                status: correction.status ?? 'pending',
              );
            },
          );
        },
      ),
    );
  }
}