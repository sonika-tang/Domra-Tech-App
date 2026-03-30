import 'package:flutter/material.dart';
import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/model/category.dart';

class CategoryFilter extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;
  final Function(int index) onCategorySelected;

  const CategoryFilter({super.key, required this.categories, required this.selectedIndex, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.background : AppColors.lightGray,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 2) // Outline when selected
                    : null, // No border when not selected
              ),
              alignment: Alignment.center,
              child: Text(
                category.translatedName(context),
                style: TextStyle(color: isSelected ? AppColors.primary : AppColors.background, fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }
}
