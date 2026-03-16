class WordTranslation {
  final int wordId;
  final String? englishWord;
  final String? frenchWord;
  final String khmerWord;
  final String? normalizedWord;
  final String? definition;
  final String? example;
  final String? imageURL;
  final String? reference;
  final String? referenceText;

  WordTranslation({
    required this.wordId,
    this.englishWord,
    this.frenchWord,
    required this.khmerWord,
    this.normalizedWord,
    this.definition,
    this.example,
    this.imageURL,
    this.reference,
    this.referenceText,
  });

  factory WordTranslation.fromJson(Map<String, dynamic> json) {
    return WordTranslation(
      wordId: json['wordId'],
      englishWord: json['EnglishWord'],
      frenchWord: json['FrenchWord'],
      khmerWord: json['KhmerWord'],
      normalizedWord: json['normalizedWord'],
      definition: json['definition'],
      example: json['example'],
      imageURL: json['imageURL'],
      reference: json['reference'],
      referenceText: json['referenceText'],
    );
  }

  get categoryId => null;
}
