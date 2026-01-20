import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary, 
      background: AppColors.background
      ),
    
    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleTextStyle: AppTextStyle.heading3,
    )
  );
}
