class FeedbackModel {
  final int userId;
  final int wordId;
  final String? message;

  FeedbackModel({
    required this.userId,
    required this.wordId,
    this.message,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      userId: json['userId'],
      wordId: json['wordId'],
      message: json['message'],
    );
  }
}
