import 'dart:convert';
import 'package:domra_tech/model/category.dart';
import 'package:domra_tech/service/category_service.dart';

class CategoryRepository {
  final CategoryService _service;

  CategoryRepository({required CategoryService service}) : _service = service;

  ///Get all category
  Future<List<Category>> getAllCategories() async {
    final response = await _service.getAllCategories();
    if (response.statusCode == 200) {
      final List jsonBody = jsonDecode(response.body);
      print(jsonBody);
      return jsonBody.map((json) => Category.fromJson(json)).toList();
    }

    return [];
  }
}
