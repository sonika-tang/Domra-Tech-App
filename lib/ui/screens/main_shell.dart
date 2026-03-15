import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../routes/app_routes.dart';
import '../../routes/navigation_helper.dart';
import 'contributions/contribution_guideline_screen.dart';
import 'favorites/favorites_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  /// Index of the tab to show first
  final int initialIndex;

  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  // The four main tab screens — preserved by IndexedStack
  static const List<Widget> _screens = [HomeScreen(), ContributionGuidelineScreen(), FavoritesScreen(), ProfileScreen()];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) return;

            setState(() => _currentIndex = index);

            switch (index) {
              case 0:
                context.replaceWith(AppRoutes.home);
                break;
              case 1:
                context.replaceWith(AppRoutes.contributionGuideline);
                break;
              case 2:
                context.replaceWith(AppRoutes.favorites);
                break;
              case 3:
                context.replaceWith(AppRoutes.profile);
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: const Color(0xFF9E9E9E),
          selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), activeIcon: const Icon(Icons.home), label: t.navHome),
            BottomNavigationBarItem(icon: const Icon(Icons.mode_edit_outline_outlined), activeIcon: const Icon(Icons.mode_edit_outline_rounded), label: t.navContribute),
            BottomNavigationBarItem(icon: const Icon(Icons.favorite_border), activeIcon: const Icon(Icons.favorite), label: t.navFavorite),
            BottomNavigationBarItem(icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: t.navProfile),
          ],
        ),
      ),
    );
  }
}
