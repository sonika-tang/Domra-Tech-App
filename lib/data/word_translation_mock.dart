import 'package:domra_tech/model/word_translation.dart';

final List<WordTranslation> mockWordTranslations = [
  WordTranslation(
    wordId: 1,
    englishWord: "Computer",
    frenchWord: "Ordinateur",
    khmerWord: "កុំព្យូទ័រ",
    normalizedWord: "computer",
    definition: "An electronic device for storing and processing data.",
    example: "I use my computer to write code.",
    imageURL: "https://example.com/images/computer.png",
    reference: "Oxford Dictionary",
    referenceText: "Oxford English Dictionary, 2020",
  ),
  WordTranslation(
    wordId: 2,
    englishWord: "Keyboard",
    frenchWord: "Clavier",
    khmerWord: "ក្តារចុច",
    definition: "A panel of keys that operate a computer or typewriter.",
    example: "The keyboard is wireless.",
  ),
  WordTranslation(wordId: 3, englishWord: "Mouse", frenchWord: "Souris", khmerWord: "កណ្តុរ​កុំព្យូទ័រ", imageURL: "https://example.com/images/mouse.png"),
  WordTranslation(wordId: 4, englishWord: "Network", khmerWord: "បណ្តាញ", definition: "A group of interconnected computers.", reference: "Techopedia"),
  WordTranslation(wordId: 5, englishWord: "Server", frenchWord: "Serveur", khmerWord: "ម៉ាស៊ីនបម្រើ", example: "The server is down for maintenance.", referenceText: "IT Glossary"),
];
