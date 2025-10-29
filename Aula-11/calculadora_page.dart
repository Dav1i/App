import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'historico_page.dart';
import 'dart:math';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String display = '0';
  double memoria = 0;
  String operacao = '';
  double? numeroAnterior;

  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final dados = await dbHelper.lerDados();
    setState(() {
      display = dados['numeroAtual'].toString();
      memoria = dados['memoria'];
    });
  }

  void atualizarBanco() {
    dbHelper.atualizarDados(double.tryParse(display) ?? 0, memoria);
  }

  void adicionarNumero(String n) {
    setState(() {
      if (display == '0') {
        display = n;
      } else {
        display += n;
      }
    });
  }

  void definirOperacao(String op) {
    numeroAnterior = double.tryParse(display);
    operacao = op;
    display = '0';
  }

  void calcularResultado() {
    double atual = double.tryParse(display) ?? 0;
    double resultado = 0;

    switch (operacao) {
      case '+':
        resultado = numeroAnterior! + atual;
        break;
      case '-':
        resultado = numeroAnterior! - atual;
        break;
      case '*':
        resultado = numeroAnterior! * atual;
        break;
      case '/':
        resultado = atual == 0 ? double.nan : numeroAnterior! / atual;
        break;
    }

    dbHelper.salvarOperacao('$numeroAnterior $operacao $atual', resultado);
    setState(() => display = resultado.toString());
    atualizarBanco();
  }

  void funcaoMemoria(String tipo) {
    double valorAtual = double.tryParse(display) ?? 0;
    switch (tipo) {
      case 'MC':
        memoria = 0;
        break;
      case 'MR':
        display = memoria.toString();
        break;
      case 'M+':
        memoria += valorAtual;
        break;
      case 'M-':
        memoria -= valorAtual;
        break;
    }
    atualizarBanco();
    setState(() {});
  }

  void limpar() {
    setState(() {
      display = '0';
      operacao = '';
      numeroAnterior = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora com Memória e SQLite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoricoPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(display, style: const TextStyle(fontSize: 48)),
            ),
          ),
          Text('Memória: $memoria', style: const TextStyle(fontSize: 18)),
          const Divider(),
          _buildBotoes(),
        ],
      ),
    );
  }

  Widget _buildBotoes() {
    final botoes = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['0', 'C', '=', '+'],
      ['MC', 'MR', 'M+', 'M-'],
    ];

    return Column(
      children: botoes
          .map(
            (linha) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: linha.map((b) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () {
                      if (RegExp(r'^[0-9]+$').hasMatch(b)) {
                        adicionarNumero(b);
                      } else if (['+', '-', '*', '/'].contains(b)) {
                        definirOperacao(b);
                      } else if (b == '=') {
                        calcularResultado();
                      } else if (b == 'C') {
                        limpar();
                      } else {
                        funcaoMemoria(b);
                      }
                    },
                    child: Text(b, style: const TextStyle(fontSize: 24)),
                  ),
                );
              }).toList(),
            ),
          )
          .toList(),
    );
  }
}
