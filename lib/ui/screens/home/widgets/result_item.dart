import 'package:domra_tech/ui/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    if (viewModel.words.isEmpty) return const SizedBox();

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.words.length,
          itemBuilder: (context, index) {
            final word = viewModel.words[index];

            return ListTile(title: Text(word.englishWord ?? ""), subtitle: Text(word.khmerWord), onTap: () {});
          },
        ),
      ),
    );
  }
}
