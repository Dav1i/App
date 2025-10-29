import 'package:flutter/material.dart';
import 'calculadora_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora SQLite',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculadoraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
