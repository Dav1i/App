import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'tabuada_page.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz + Tabuada',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz + Tabuada')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Quiz de Conhecimentos Gerais'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => QuizPage()));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Treino de Tabuada'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TabuadaPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
