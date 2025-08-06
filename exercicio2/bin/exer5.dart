import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotação do Dólar',
      home: CotacaoScreen(),
    );
  }
}

class CotacaoScreen extends StatefulWidget {
  @override
  _CotacaoScreenState createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<CotacaoScreen> {
  String cotacao = '';

  @override
  void initState() {
    super.initState();
    _obterCotacao();
  }

  Future<void> _obterCotacao() async {
    // API para obter cotação do dólar (usar a data 03/07/2025)
    final response = await http.get(Uri.parse(
        'https://api.bcb.gov.br/dados/serie/bcdata.sgs.1/cotacao/2025-07-03/2025-07-03?formato=application/json'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        cotacao = 'Cotação do dólar em 03/07/2025: R\$ ${data[0]['valor']}';
      });
    } else {
      setState(() {
        cotacao = 'Erro ao buscar cotação.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cotação do Dólar')),
      body: Center(
        child: Text(cotacao, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
