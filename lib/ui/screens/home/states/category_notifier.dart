import 'package:domra_tech/data/repo/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:domra_tech/model/category.dart';

class CategoryNotifier extends ChangeNotifier {
  final CategoryRepository repository;

  List<Category> categories = [];
  int selectedIndex = 0;
  int? selectedCategoryId;

  CategoryNotifier({required this.repository}) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      categories = await repository.getAllCategories();

      // Optional: add All
      categories.insert(0, Category(categoryId: 0, categoryName: "All", description: "contain all category"));

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  void selectCategory(int index) {
    selectedIndex = index;
    selectedCategoryId = categories[index].categoryId;
    notifyListeners();
  }
}
