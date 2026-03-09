import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './payment_test.dart'; // Import the file where your BakongTestScreen is

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BakongTestApp());
}

class BakongTestApp extends StatelessWidget {
  const BakongTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakong Payment Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red, // Bakong uses red/gold themes usually
        useMaterial3: true,
      ),
      home: const BakongTestScreen(),
    );
  }
}
