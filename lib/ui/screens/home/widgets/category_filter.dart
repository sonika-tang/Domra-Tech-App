import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/model/category.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryFilter({super.key, required this.categories, required this.selectedIndex, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          final category = categories[index];

          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: isSelected ? AppColors.background : AppColors.lightGray, borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  category.categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: isSelected ? AppColors.primary : AppColors.background, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
