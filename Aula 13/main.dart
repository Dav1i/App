import 'package:flutter/material.dart';
import 'localizacao.dart'; 
import 'clima.dart'; 

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double? latitude;
  double? longitude;
  double? temperatura;
  int? umidade;
  double? velocidadeVento;
  bool carregando = true;

  Future<void> obterDados() async {
    Localizacao localizacao = Localizacao();
    await localizacao.pegaLocalizacaoAtual();
    setState(() {
      latitude = localizacao.latitude;
      longitude = localizacao.longitude;
      carregando = false;
    });

    if (latitude != null && longitude != null) {
      Clima clima = await Clima.obterClima(latitude!, longitude!);
      setState(() {
        temperatura = clima.temperatura;
        umidade = clima.umidade;
        velocidadeVento = clima.velocidadeVento;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    obterDados();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Clima e Localização')),
        body: Center(
          child: carregando
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Latitude: $latitude'),
                    Text('Longitude: $longitude'),
                    const SizedBox(height: 20),
                    Text('Temperatura: ${temperatura?.toStringAsFixed(1)} °C'),
                    Text('Umidade: $umidade%'),
                    Text(
                        'Velocidade do Vento: ${velocidadeVento?.toStringAsFixed(1)} m/s'),
                  ],
                ),
        ),
      ),
    );
  }
}

