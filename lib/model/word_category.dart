class WordCategory {
  final int wordId;
  final int categoryId;

  WordCategory({
    required this.wordId,
    required this.categoryId,
  });

  factory WordCategory.fromJson(Map<String, dynamic> json) {
    return WordCategory(
      wordId: json['wordId'],
      categoryId: json['categoryId'],
    );
  }
}
