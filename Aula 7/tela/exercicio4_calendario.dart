import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CalendarPage()));
}

class CalendarPage extends StatelessWidget {
  List<Widget> _buildCalendar(BuildContext context) {
    DateTime hoje = DateTime.now();
    // ignore: unused_local_variable
    DateTime inicio = DateTime(hoje.year, hoje.month, 1);
    int dias = DateTime(hoje.year, hoje.month + 1, 0).day;

    return List.generate(dias, (i) {
      DateTime dia = DateTime(hoje.year, hoje.month, i + 1);
      return TextButton(
        child: Text("${i + 1}"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DiaPage(
                numero: dia.day,
                semana: [
                  "Seg",
                  "Ter",
                  "Qua",
                  "Qui",
                  "Sex",
                  "Sáb",
                  "Dom"
                ][dia.weekday - 1],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendário")),
      body: GridView.count(
        crossAxisCount: 7,
        children: _buildCalendar(context),
      ),
    );
  }
}

class DiaPage extends StatelessWidget {
  final int numero;
  final String semana;

  DiaPage({required this.numero, required this.semana});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dia")),
      body: Center(
        child: Text(
          "$semana - Dia $numero",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
