import 'package:flutter/material.dart';

class WordDetailScreen extends StatelessWidget {
  final int wordId;
  final String? englishWord;
  final String? khmerWord;
  final String? frenchWord;
  final String? definition;
  final String? example;
  final String? imageURL;
  final String? reference;

  const WordDetailScreen({
    super.key,
    required this.wordId,
    this.englishWord,
    this.khmerWord,
    this.frenchWord,
    this.definition,
    this.example,
    this.imageURL,
    this.reference,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Word Detail')),
    body: Center(child: Text('Word #$wordId: $englishWord')),
  );
}
