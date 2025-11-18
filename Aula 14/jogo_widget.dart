import 'package:flutter/material.dart';
import 'deck_service.dart';

class TelaJogoCartas extends StatefulWidget {
  @override
  _TelaJogoCartasState createState() => _TelaJogoCartasState();
}

class _TelaJogoCartasState extends State<TelaJogoCartas> {
  String deckId = "";
  Carta? jogador;
  Carta? maquina;

  int pontosJogador = 0;
  int pontosMaquina = 0;

  @override
  void initState() {
    super.initState();
    iniciar();
  }

  Future<void> iniciar() async {
    deckId = await criarDeck();
    setState(() {});
  }

  Future<void> jogar() async {
    jogador = await puxarCarta(deckId);
    maquina = await puxarCarta(deckId);

    if (jogador!.valor > maquina!.valor) pontosJogador++;
    if (maquina!.valor > jogador!.valor) pontosMaquina++;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jogo de Cartas")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Jogador: $pontosJogador   |   Computador: $pontosMaquina",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                maquina == null
                    ? Container(width: 120, height: 180, color: Colors.grey)
                    : Image.network(maquina!.imagem, width: 120),
                jogador == null
                    ? Container(width: 120, height: 180, color: Colors.grey)
                    : Image.network(jogador!.imagem, width: 120),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: jogar,
              child: Text("Jogar"),
            ),
          ],
        ),
      ),
    );
  }
}
