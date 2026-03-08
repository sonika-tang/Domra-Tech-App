import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/ui/screens/home/widgets/category_filter.dart';
import 'package:domra_tech/ui/screens/home/widgets/results_list.dart';
import 'package:domra_tech/ui/screens/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:domra_tech/mockdata/categories_mock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox.expand(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              color: AppColors.primary,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                children: [
                  //SEARCH BAR
                  const SearchBarSection(),
                  const SizedBox(height: 12),
                  //CATEGORIES
                  CategoryFilter(
                    categories: mockCategories,
                    selectedIndex: selectedCategoryIndex,
                    onCategorySelected: (index) {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                  ),
                ],
              ),
            ),

            // WORD LIST
            const Expanded(child: WordList()),
          ],
        ),
      ),
    );
  }
}
