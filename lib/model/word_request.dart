class WordRequest {
  final int wordRequestId;
  final String? newEnglishWord;
  final String? newFrenchWord;
  final String? newKhmerWord;
  final String? newDefinition;
  final String? newExample;
  final String? reference;
  final int userId;
  final String? status;
  final bool check;
  final DateTime? createdAt;

  WordRequest({
    required this.wordRequestId,
    this.newEnglishWord,
    this.newFrenchWord,
    this.newKhmerWord,
    this.newDefinition,
    this.newExample,
    this.reference,
    required this.userId,
    this.status,
    required this.check,
    this.createdAt,
  });

  factory WordRequest.fromJson(Map<String, dynamic> json) {
    return WordRequest(
      wordRequestId: json['wordRequestId'],
      newEnglishWord: json['newEnglishWord'],
      newFrenchWord: json['newFrenchWord'],
      newKhmerWord: json['newKhmerWord'],
      newDefinition: json['newDefinition'],
      newExample: json['newExample'],
      reference: json['reference'],
      userId: json['userId'],
      status: json['status'],
      check: json['check'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
