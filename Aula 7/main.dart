import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MenuPage(),
  ));
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu de Exercícios")),
      body: Center(
        child: Text(
          "Funcionando!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
