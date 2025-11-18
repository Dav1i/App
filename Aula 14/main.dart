import 'package:flutter/material.dart';
import 'clima_widget.dart';
import 'dicionario_widget.dart';
import 'jogo_widget.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaMenu(),
    );
  }
}

class TelaMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu de Aplicações")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Clima"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TelaClima())),
          ),
          ListTile(
            title: Text("Dicionário"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TelaDicionario())),
          ),
          ListTile(
            title: Text("Jogo de Cartas"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TelaJogoCartas())),
          ),
        ],
      ),
    );
  }
}
