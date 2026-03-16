import 'package:http/http.dart' as http;
import '../core/config/constants.dart';

class CategoryService {
  final http.Client client;
  CategoryService(this.client);

  /// Fetch all categories
  Future<http.Response> getAllCategories() async {
    final uri = Uri.parse('$baseUrl/categories');
    return await client.get(uri);
  }

  /// Get category by ID
  Future<http.Response> getCategoryById(String categoryId) async {
    final uri = Uri.parse('$baseUrl/categories/$categoryId');
    return await client.get(uri);
  }
}
