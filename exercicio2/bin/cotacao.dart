// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
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
    DateTime today = DateTime.now();
    DateTime dateToFetch;

    // Verifica se ontem foi domingo
    if (today.weekday == DateTime.monday) {
      dateToFetch = today.subtract(Duration(days: 2)); // sexta-feira
    } else {
      dateToFetch = today.subtract(Duration(days: 1)); // ontem
    }

    String dateString =
        '${dateToFetch.year}-${dateToFetch.month.toString().padLeft(2, '0')}-${dateToFetch.day.toString().padLeft(2, '0')}';

    // Chamada à API para pegar a cotação de ontem ou sexta-feira
    final response = await http.get(Uri.parse(
        'https://api.bcb.gov.br/dados/serie/bcdata.sgs.1/cotacao/$dateString/$dateString?formato=application/json'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        cotacao = 'Cotação do dólar em $dateString: R\$ ${data[0]['valor']}';
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
