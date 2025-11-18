import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> buscarDefinicao(String palavra) async {
  final url = "https://api.dictionaryapi.dev/api/v2/entries/en/$palavra";

  final resp = await http.get(Uri.parse(url));
  if (resp.statusCode != 200) return null;

  final json = jsonDecode(resp.body);
  return json[0]["meanings"][0]["definitions"][0]["definition"];
}
