import 'package:domra_tech/core/config/theme.dart';
import 'package:domra_tech/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class DomraTech extends StatelessWidget {
  const DomraTech({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: AppTheme.lightTheme, 
      home: const HomeScreen()
      );
  }
}
