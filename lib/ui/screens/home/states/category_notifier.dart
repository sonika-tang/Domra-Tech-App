import 'package:domra_tech/repo/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:domra_tech/model/category.dart';

class CategoryNotifier extends ChangeNotifier {
  final CategoryRepository repository;
  List<Category> categories = [];
  int selectedIndex = 0;

  CategoryNotifier({required this.repository}) {
    fetchCategories();
  }

  /// Fetch all categories using repository
  Future<void> fetchCategories() async {
    try {
      categories = await repository.getAllCategories();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  /// Update selected category index
  void selectCategory(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
