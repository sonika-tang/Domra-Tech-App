import 'package:domra_tech/core/config/app_colors.dart';
import 'package:domra_tech/core/config/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    //configure color theme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.background,

      secondary: AppColors.secondary,
      onSecondary: AppColors.background,

      background: AppColors.background,
      onBackground: AppColors.textPrimary,

      primaryContainer: AppColors.primaryBackground,
      onPrimaryContainer: AppColors.gray,

      secondaryContainer: AppColors.secondaryBackground,
      onSecondaryContainer: AppColors.secondaryHover,

      tertiaryContainer: AppColors.lightGray,
      onTertiaryContainer: AppColors.gray,

      error: AppColors.error,
      onError: Colors.white,

    ),

    //configure text theme
    textTheme: const TextTheme(
      displayLarge: AppTextStyle.largeTitle,
      headlineLarge: AppTextStyle.heading1,
      headlineMedium: AppTextStyle.heading2,
      headlineSmall: AppTextStyle.heading3,

      bodyLarge: AppTextStyle.body1,
      bodyMedium: AppTextStyle.body2,
      bodySmall: AppTextStyle.small,
    ),

    //config scaffold default color
    scaffoldBackgroundColor: AppColors.background,

    //config app bar default color
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary, elevation: 0, titleTextStyle: AppTextStyle.heading3),
  );
}
