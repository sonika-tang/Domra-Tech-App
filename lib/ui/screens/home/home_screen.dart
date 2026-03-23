import 'package:domra_tech/data/repo/category_repository.dart';
import 'package:domra_tech/ui/screens/home/states/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/ui/screens/home/widgets/category_filter.dart';
import 'package:domra_tech/ui/screens/home/widgets/results_list.dart';
import 'package:domra_tech/ui/screens/home/widgets/search_bar.dart';
import 'package:domra_tech/service/category_service.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryNotifier(repository: CategoryRepository(service: CategoryService(http.Client()))),
      child: Scaffold(
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
          child: Consumer<CategoryNotifier>(
            builder: (context, notifier, _) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.primary,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SearchBarSection(),
                        const SizedBox(height: 12),
                        notifier.categories.isEmpty
                            ? const CircularProgressIndicator(color: Colors.white)
                            : CategoryFilter(
                                categories: notifier.categories,
                                selectedIndex: notifier.selectedIndex,
                                onCategorySelected: (index) {
                                  notifier.selectCategory(index);
                                },
                              ),
                      ],
                    ),
                  ),
                  // Display results 
                  const Expanded(child: WordList()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
