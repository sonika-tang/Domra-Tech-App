import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;
  final String? category;

  const SearchResultsScreen({super.key, required this.query, this.category});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Search: $query')),
    body: Center(child: Text('Results for $query')),
  );
}
