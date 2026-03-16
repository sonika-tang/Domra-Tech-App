import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../state/models/contribution_state.dart';
import 'widgets/history_item.dart';

class HistoryNewWordsScreen extends StatefulWidget {
  const HistoryNewWordsScreen({super.key});

  @override
  State<HistoryNewWordsScreen> createState() => _HistoryNewWordsScreenState();
}

class _HistoryNewWordsScreenState extends State<HistoryNewWordsScreen> {
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
      appBar: AppBar(title: Text(t.newWord), elevation: 0, backgroundColor: colorScheme.primary),
      body: Consumer<ContributionNotifier>(
        builder: (context, contribProvider, child) {
          final wordRequests = contribProvider.state.wordRequests;

          if (contribProvider.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wordRequests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_add, size: 64, color: colorScheme.outline.withValues(alpha: .3)),
                  const SizedBox(height: 16),
                  Text('No word requests yet', style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.outline)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: wordRequests.length,
            itemBuilder: (context, index) {
              final wr = wordRequests[index];
              return HistoryItem(
                title: wr.newEnglishWord ?? 'Untitled',
                description: 'Khmer: ${wr.newKhmerWord ?? '-'}  •  French: ${wr.newFrenchWord ?? '-'}',
                status: wr.status ?? 'pending',
              );
            },
          );
        },
      ),
    );
  }
}
