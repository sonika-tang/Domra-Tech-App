import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/language_provider.dart';

class TestLangScreen extends StatelessWidget {
  const TestLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    final t = AppLocalizations.of(context);

    if (t == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.login)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.chooseLanguage, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Current: ${provider.locale.languageCode.toUpperCase()}"),

            const SizedBox(height: 30),

            // English Button
            ElevatedButton(onPressed: () => provider.setLocale(const Locale('en')), child: const Text("English")),

            // Khmer Button
            ElevatedButton(onPressed: () => provider.setLocale(const Locale('km')), child: const Text("ភាសាខ្មែរ")),

            const SizedBox(height: 30),

            Card(
              child: Padding(padding: const EdgeInsets.all(16.0), child: Text(t.search)),
            ),
          ],
        ),
      ),
    );
  }
}
