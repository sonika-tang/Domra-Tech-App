import 'package:domra_tech/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String categoryName;
  final String description;

  Category({required this.categoryId, required this.categoryName, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(categoryId: json['categoryId'], categoryName: json['categoryName'], description: json['description']);
  }

  /// Get translated name based on locale
  String translatedName(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    switch (categoryId) {
      case 1:
        return local.ds;
      case 2:
        return local.cs;
      case 3:
        return local.programming;
      case 4:
        return local.webDev;
      case 5:
        return local.ai;
      case 6:
        return local.ml;
      case 7:
        return local.general;
      default:
        return local.all; // fallback to backend name
    }
  }
}
