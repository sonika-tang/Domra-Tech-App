import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'favorites/favorites_screen.dart';
import 'profile/profile_screen.dart';
import 'contributions/contribution_screen.dart'; // example contribution screen
import 'package:domra_tech/l10n/app_localizations.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), ContributionScreen(), FavoritesScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar _buildAppBar(AppLocalizations loc) {
    switch (_selectedIndex) {
      case 0: // Home
        return AppBar(
          centerTitle: true,
          title: Image.asset("assets/imgs/domra_logo.png", width: 128, height: 27),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.notifications_none, color: Colors.white),
            ),
          ],
        );
      case 1: // Favorites
        return AppBar(title: Text(loc.navContribute), centerTitle: true);
      case 2: // Profile
        return AppBar(title: Text(loc.navFavorite), centerTitle: true);
      case 3: // Contributions
        return AppBar(title: Text(loc.navProfile), centerTitle: true);
      default:
        return AppBar(title: const Text("Domra"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: _buildAppBar(loc),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: loc.navHome),
          BottomNavigationBarItem(icon: const Icon(Icons.add_box), label: loc.navContribute),
          BottomNavigationBarItem(icon: const Icon(Icons.favorite), label: loc.navFavorite),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: loc.navProfile),
        ],
      ),
    );
  }
}
