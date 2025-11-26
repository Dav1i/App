import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: RaioPage(),
  ));
}

class RaioPage extends StatelessWidget {
  final TextEditingController raioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Informe o raio")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: raioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Raio"),
            ),
            ElevatedButton(
              onPressed: () {
                double raio = double.parse(raioController.text);
                double area = 3.14159 * raio * raio;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultadoPage(area: area),
                  ),
                );
              },
              child: Text("Calcular"),
            )
          ],
        ),
      ),
    );
  }
}

class ResultadoPage extends StatelessWidget {
  final double area;

  ResultadoPage({required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Área")),
      body: Center(
        child: Text("Área = ${area.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 28)),
      ),
    );
  }
}
