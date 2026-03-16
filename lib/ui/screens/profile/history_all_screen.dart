import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';
import '../../../state/models/contribution_state.dart';
import 'widgets/history_item.dart';

enum SortOption { newest, oldest, aToZ, zToA }

// Wrapper class for unified listing
class _ContributionEntry {
  final String title;
  final String description;
  final String status;
  final DateTime date;

  _ContributionEntry({
    required this.title,
    required this.status,
    required this.date,
  }) : description = 'Submitted ${DateFormat('dd/MM/yyyy').format(date)}';
}

class HistoryAllScreen extends StatefulWidget {
  const HistoryAllScreen({super.key});

  @override
  State<HistoryAllScreen> createState() => _HistoryAllScreenState();
}

class _HistoryAllScreenState extends State<HistoryAllScreen> {
  SortOption _currentSort = SortOption.newest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContributionNotifier>().fetchContributions();
    });
  }

  void _showFilterOptions() {
    final t = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  t.sortBy,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildFilterTile(
                t.newestToOldest,
                Icons.keyboard_double_arrow_down,
                SortOption.newest,
              ),
              _buildFilterTile(
                t.oldestToNewest,
                Icons.keyboard_double_arrow_up,
                SortOption.oldest,
              ),
              _buildFilterTile(t.aToZ, Icons.sort_by_alpha, SortOption.aToZ),
              _buildFilterTile(t.zToA, Icons.sort_by_alpha, SortOption.zToA),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterTile(String title, IconData icon, SortOption option) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        color: _currentSort == option ? const Color(0xFF4C51C6) : Colors.grey,
      ),
      trailing: _currentSort == option
          ? const Icon(Icons.check, color: Color(0xFF4C51C6))
          : null,
      onTap: () {
        setState(() => _currentSort = option);
        Navigator.pop(context);
      },
    );
  }

  void _sortEntries(List<_ContributionEntry> entries) {
    entries.sort((a, b) {
      switch (_currentSort) {
        case SortOption.newest:
          return b.date.compareTo(a.date);
        case SortOption.oldest:
          return a.date.compareTo(b.date);
        case SortOption.aToZ:
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
        case SortOption.zToA:
          return b.title.toLowerCase().compareTo(a.title.toLowerCase());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          title: Text(t.contributionHistory),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(
            0xFF3F51B5,
          ), // Deep Blue appbar matching screenshot
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: const Color(0xFF4C51C6),
                      labelColor: const Color(0xFF4C51C6),
                      unselectedLabelColor: Colors.grey,
                      dividerColor: Colors.transparent,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      tabs: [
                        Tab(text: t.all),
                        Tab(text: t.newWord),
                        Tab(text: t.wordCorrection),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: Color(0xFF4C51C6)),
                    onPressed: _showFilterOptions,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
        body: Consumer<ContributionNotifier>(
          builder: (context, contribProvider, child) {
            final state = contribProvider.state;

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(
                child: Text(
                  state.error!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              );
            }

            final allReqs = state.wordRequests;
            final allCorrs = state.corrections;

            List<_ContributionEntry> requestEntries = allReqs
                .map(
                  (wr) => _ContributionEntry(
                    title: wr.newEnglishWord ?? 'Untitled',
                    status: wr.status ?? 'pending',
                    date: wr.createdAt ?? DateTime(2025, 11, 29),
                  ),
                )
                .toList();

            List<_ContributionEntry> correctionEntries = allCorrs
                .map(
                  (c) => _ContributionEntry(
                    title: c.correctEnglishWord ?? 'Correction',
                    status: c.status ?? 'pending',
                    date: c.createdAt ?? DateTime(2025, 11, 29),
                  ),
                )
                .toList();

            List<_ContributionEntry> unifiedEntries = [
              ...requestEntries,
              ...correctionEntries,
            ];

            _sortEntries(unifiedEntries);
            _sortEntries(requestEntries);
            _sortEntries(correctionEntries);

            return TabBarView(
              children: [
                _buildListView(unifiedEntries, theme, colorScheme, context),
                _buildListView(requestEntries, theme, colorScheme, context),
                _buildListView(correctionEntries, theme, colorScheme, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildListView(
    List<_ContributionEntry> items,
    ThemeData theme,
    ColorScheme colorScheme,
    BuildContext context,
  ) {
    final t = AppLocalizations.of(context)!;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: colorScheme.outline.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              t.noContributionsYet,
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
      itemCount: items.length,
      itemBuilder: (context, index) {
        final e = items[index];
        return HistoryItem(
          title: e.title,
          description: e.description,
          status: e.status,
        );
      },
    );
  }
}
