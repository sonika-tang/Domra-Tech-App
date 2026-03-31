import 'package:domra_tech/ui/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/ui/screens/home/widgets/category_filter.dart';
import 'package:domra_tech/ui/screens/home/widgets/results_list.dart';
import 'package:domra_tech/ui/screens/home/widgets/search_bar.dart';
import 'package:domra_tech/ui/screens/home/states/category_notifier.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:domra_tech/state/models/favorite_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Fetch favorites once when HomeScreen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await _storage.read(key: 'jwt');

      if (token != null) {
        await context.read<FavoriteNotifier>().fetchFavorites(token);
      }
      
      // Load initial words
      if (mounted) {
        await context.read<HomeViewModel>().fetchRecentWords();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset("assets/imgs/domra_logo.png", width: 128, height: 27),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer2<CategoryNotifier, HomeViewModel>(
          builder: (context, categoryNotifier, homeVM, _) {
            return Column(
              children: [
                /// HEADER SECTION
                Container(
                  width: double.infinity,
                  color: AppColors.primary,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SearchBarSection(),
                      const SizedBox(height: 12),

                      /// CATEGORY FILTER
                      categoryNotifier.categories.isEmpty
                          ? const CircularProgressIndicator(color: Colors.white)
                          : CategoryFilter(
                              categories: categoryNotifier.categories,
                              selectedIndex: categoryNotifier.selectedIndex,
                              onCategorySelected: (index) async {
                                categoryNotifier.selectCategory(index);
                                final selectedCategory = categoryNotifier.categories[index];
                                await homeVM.filterByCategory(selectedCategory.categoryId);
                              },
                            ),
                    ],
                  ),
                ),

                /// WORD RESULT LIST
                if (homeVM.hasReachedSearchLimit)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock_outline, size: 64, color: AppColors.primary),
                            const SizedBox(height: 16),
                            const Text(
                              "You've reached your free search limit!", 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Subscribe to premium for unlimited access to the lexicon.",
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/subscription-plans');
                              },
                              child: const Text("Upgrade Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            )
                          ]
                        )
                      )
                    )
                  )
                else ...[
                  if (homeVM.isOfflineData)
                    Container(
                      width: double.infinity,
                      color: Colors.orange.shade100,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off_outlined, size: 16, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            "Offline mode: Data may be outdated",
                            style: TextStyle(color: Colors.orange, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  const Expanded(child: WordList()),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
