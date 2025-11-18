import 'dart:convert';
import 'package:http/http.dart' as http;

class Carta {
  final String imagem;
  final int valor;

  Carta(this.imagem, this.valor);
}

int converterValor(String v) {
  switch (v) {
    case "JACK":
      return 11;
    case "QUEEN":
      return 12;
    case "KING":
      return 13;
    case "ACE":
      return 14;
    default:
      return int.tryParse(v) ?? 0;
  }
}

Future<Carta> puxarCarta(String deckId) async {
  final url = "https://deckofcardsapi.com/api/deck/$deckId/draw/?count=1";
  final resp = await http.get(Uri.parse(url));
  final json = jsonDecode(resp.body);

  final c = json["cards"][0];
  return Carta(
    c["image"],
    converterValor(c["value"]),
  );
}

Future<String> criarDeck() async {
  final resp = await http.get(Uri.parse(
      "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"));
  final json = jsonDecode(resp.body);
  return json["deck_id"];
}
