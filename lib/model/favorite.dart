class Favorite {
  final int userId;
  final int wordId;

  Favorite({
    required this.userId,
    required this.wordId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      userId: json['userId'],
      wordId: json['wordId'],
    );
  }
}
