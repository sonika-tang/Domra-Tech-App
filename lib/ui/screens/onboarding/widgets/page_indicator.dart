import 'package:flutter/material.dart';
import 'package:domra_tech/core/config/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;

  const PageIndicator({
    super.key,
    required this.totalPages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index + 1 == currentPage;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.gray,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
