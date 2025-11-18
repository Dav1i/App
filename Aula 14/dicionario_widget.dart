import 'package:flutter/material.dart';
import 'dic_service.dart';

class TelaDicionario extends StatefulWidget {
  @override
  _TelaDicionarioState createState() => _TelaDicionarioState();
}

class _TelaDicionarioState extends State<TelaDicionario> {
  final ctrl = TextEditingController();
  String definicao = "";

  Future<void> buscar() async {
    final def = await buscarDefinicao(ctrl.text);
    setState(() => definicao = def ?? "Palavra não encontrada.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dicionário de Inglês")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: ctrl,
                decoration: InputDecoration(labelText: "Palavra")),
            SizedBox(height: 12),
            ElevatedButton(onPressed: buscar, child: Text("Buscar")),
            SizedBox(height: 20),
            Text(definicao),
          ],
        ),
      ),
    );
  }
}
