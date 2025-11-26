import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DadosAlunoPage()));
}

class DadosAlunoPage extends StatelessWidget {
  final nomeController = TextEditingController();
  final matriculaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aluno")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: matriculaController,
              decoration: InputDecoration(labelText: "Matrícula"),
            ),
            ElevatedButton(
              child: Text("Próximo"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotasPage(
                      nome: nomeController.text,
                      matricula: matriculaController.text,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class NotasPage extends StatefulWidget {
  final String nome;
  final String matricula;

  NotasPage({required this.nome, required this.matricula});

  @override
  _NotasPageState createState() => _NotasPageState();
}

class _NotasPageState extends State<NotasPage> {
  final notaController = TextEditingController();
  List<double> notas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lançar Notas")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: notaController,
              decoration: InputDecoration(labelText: "Nota"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: Text("Adicionar"),
              onPressed: () {
                setState(() => notas.add(double.parse(notaController.text)));
                notaController.clear();
              },
            ),
            ElevatedButton(
              child: Text("Ver Dados"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultadoAlunoPage(
                      nome: widget.nome,
                      matricula: widget.matricula,
                      notas: notas,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ResultadoAlunoPage extends StatelessWidget {
  final String nome;
  final String matricula;
  final List<double> notas;

  ResultadoAlunoPage({
    required this.nome,
    required this.matricula,
    required this.notas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dados do Aluno")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: $nome", style: TextStyle(fontSize: 18)),
            Text("Matrícula: $matricula", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Notas:", style: TextStyle(fontSize: 22)),
            Expanded(
              child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text("Nota ${i + 1}: ${notas[i]}"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
