import 'package:flutter/material.dart';
import 'screens/villa_list_screen.dart';

void main() {
  runApp(const LohonoApp());
}

class LohonoApp extends StatelessWidget {
  const LohonoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lohono Villas',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const VillaListScreen(),
    );
  }
}
