class CorrectionRequest {
  final int correctionId;
  final int userId;
  final int wordId;
  final String? correctEnglishWord;
  final String? correctFrenchWord;
  final String? correctKhmerWord;
  final String? reference;
  final String? status;
  final String? imageURL;
  final DateTime? createdAt;

  CorrectionRequest({
    required this.correctionId,
    required this.userId,
    required this.wordId,
    this.correctEnglishWord,
    this.correctFrenchWord,
    this.correctKhmerWord,
    this.reference,
    this.imageURL,
    this.status,
    this.createdAt,
  });

  factory CorrectionRequest.fromJson(Map<String, dynamic> json) {
    return CorrectionRequest(
      correctionId: json['correctionId'],
      userId: json['userId'],
      wordId: json['wordId'],
      correctEnglishWord: json['correctEnglishWord'],
      correctFrenchWord: json['correctFrenchWord'],
      correctKhmerWord: json['correctKhmerWord'],
      reference: json['reference'],
      status: json['status'],
      imageURL: json['imageURL'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
