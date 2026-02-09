class Category {
  final int categoryId;
  final String categoryName;
  final String description;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      description: json['description'],
    );
  }
}
