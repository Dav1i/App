import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JogoPage(),
    );
  }
}

class JogoPage extends StatefulWidget {
  @override
  State<JogoPage> createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  final imagens = [
    'https://t3.ftcdn.net/jpg/01/23/14/80/360_F_123148069_wkgBuIsIROXbyLVWq7YNhJWPcxlamPeZ.jpg',
    'https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/KAcAAOSwTw5bnTbW/\$_57.JPG',
    'https://t4.ftcdn.net/jpg/02/55/26/63/360_F_255266320_plc5wjJmfpqqKLh0WnJyLmjc6jFE9vfo.jpg',
  ];

  final opcoes = ["Pedra", "Papel", "Tesoura"];
  final player = AudioPlayer();

  int jogadas = 0;
  String escolhaUsuario = "";
  String escolhaApp = "";
  String resultado = "";

  // Som
  void tocarSom(String tipo) {
    player.play(AssetSource("sounds/$tipo.mp3"));
  }

  // Aleatoriedade manipulada
  String escolherApp(String user) {
    jogadas++;

    if (jogadas % 5 != 0) {
      // máquina força a vitória
      if (user == "Pedra") return "Papel";
      if (user == "Papel") return "Tesoura";
      if (user == "Tesoura") return "Pedra";
    }

    // Na 5ª jogada → usuário vence
    if (user == "Pedra") return "Tesoura";
    if (user == "Papel") return "Pedra";
    if (user == "Tesoura") return "Papel";

    return opcoes[Random().nextInt(3)];
  }

  void jogar(String user) {
    setState(() {
      escolhaUsuario = user;
      escolhaApp = escolherApp(user);

      if (user == escolhaApp) {
        resultado = "Empate!";
        tocarSom("empate");
      } else if ((user == "Pedra" && escolhaApp == "Tesoura") ||
          (user == "Papel" && escolhaApp == "Pedra") ||
          (user == "Tesoura" && escolhaApp == "Papel")) {
        resultado = "Você ganhou!";
        tocarSom("win");
      } else {
        resultado = "A máquina ganhou!";
        tocarSom("lose");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pedra-Papel-Tesoura")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (escolhaApp.isNotEmpty)
            Image.network(
              imagens[opcoes.indexOf(escolhaApp)],
              height: 200,
            ),
          const SizedBox(height: 20),
          Text("Você: $escolhaUsuario"),
          Text("Máquina: $escolhaApp"),
          Text(
            resultado,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: opcoes
                .map(
                  (op) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () => jogar(op),
                      child: Text(op),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
