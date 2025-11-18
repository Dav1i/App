import 'package:flutter/material.dart';
import 'clima_service.dart';

class TelaClima extends StatefulWidget {
  @override
  _TelaClimaState createState() => _TelaClimaState();
}

class _TelaClimaState extends State<TelaClima> {
  final cidadeCtrl = TextEditingController();
  String resultado = "";

  Future<void> buscar() async {
    final loc = await buscarLatLong(cidadeCtrl.text);
    if (loc == null) {
      setState(() => resultado = "Cidade não encontrada.");
      return;
    }

    final clima = await buscarClima(loc["lat"]!, loc["lon"]!);
    if (clima == null) {
      setState(() => resultado = "Erro ao buscar clima.");
      return;
    }

    setState(() {
      resultado = """
Temperatura: ${clima.temperatura}°C
Umidade: ${clima.umidade}%
Velocidade do Vento: ${clima.vento} km/h
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clima da Cidade")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: cidadeCtrl,
              decoration: InputDecoration(labelText: "Cidade"),
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: buscar, child: Text("Buscar")),
            SizedBox(height: 20),
            Text(resultado),
          ],
        ),
      ),
    );
  }
}
