import 'dart:convert';
import 'package:http/http.dart' as http;

class Clima {
  final double temperatura;
  final int umidade;
  final double velocidadeVento;

  Clima(
      {required this.temperatura,
      required this.umidade,
      required this.velocidadeVento});

  static Future<Clima> obterClima(double latitude, double longitude) async {
    const apiKey =
        'SUA_API_KEY_AQUI'; 
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=pt_br';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double temperatura = data['main']['temp'];
      int umidade = data['main']['humidity'];
      double velocidadeVento = data['wind']['speed'];

      return Clima(
        temperatura: temperatura,
        umidade: umidade,
        velocidadeVento: velocidadeVento,
      );
    } else {
      throw Exception('Falha ao carregar dados climáticos');
    }
  }
}

