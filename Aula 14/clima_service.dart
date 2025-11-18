import 'dart:convert';
import 'package:http/http.dart' as http;

class Clima {
  final double temperatura;
  final double umidade;
  final double vento;

  Clima(this.temperatura, this.umidade, this.vento);
}

Future<Map<String, double>?> buscarLatLong(String cidade) async {
  final url =
      "https://geocoding-api.open-meteo.com/v1/search?name=$cidade&count=1&language=pt&format=json";

  final resp = await http.get(Uri.parse(url));
  if (resp.statusCode != 200) return null;

  final json = jsonDecode(resp.body);
  if (json["results"] == null) return null;

  final r = json["results"][0];
  return {
    "lat": r["latitude"] * 1.0,
    "lon": r["longitude"] * 1.0,
  };
}

Future<Clima?> buscarClima(double lat, double lon) async {
  final url =
      "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,wind_speed_10m";

  final resp = await http.get(Uri.parse(url));
  if (resp.statusCode != 200) return null;

  final json = jsonDecode(resp.body);
  final c = json["current"];

  return Clima(
    c["temperature_2m"] * 1.0,
    c["relative_humidity_2m"] * 1.0,
    c["wind_speed_10m"] * 1.0,
  );
}
