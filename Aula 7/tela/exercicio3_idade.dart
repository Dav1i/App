import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: BirthPage()));
}

class BirthPage extends StatelessWidget {
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data de Nascimento")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Data (AAAA-MM-DD)",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                DateTime nascimento = DateTime.parse(dateController.text);
                DateTime agora = DateTime.now();

                int idade = agora.year - nascimento.year;
                if (agora.month < nascimento.month ||
                    (agora.month == nascimento.month &&
                        agora.day < nascimento.day)) {
                  idade--;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IdadePage(idade: idade),
                  ),
                );
              },
              child: Text("Ver Idade"),
            )
          ],
        ),
      ),
    );
  }
}

class IdadePage extends StatelessWidget {
  final int idade;

  IdadePage({required this.idade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Idade")),
      body: Center(
        child: Text(
          "Idade: $idade anos",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
