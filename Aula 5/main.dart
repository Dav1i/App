import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  int? operador1;
  int? operador2;
  bool somaApertado = false;
  int? resultado;

  void _pressionar(String valor) {
    setState(() {
      if (valor == "+") {
        somaApertado = true;
      } else if (valor == "=") {
        if (operador1 != null && operador2 != null) {
          resultado = operador1! + operador2!;
        }
      } else {
        int numero = int.parse(valor);
        if (!somaApertado) {
          operador1 = (operador1 ?? 0) * 10 + numero;
        } else {
          operador2 = (operador2 ?? 0) * 10 + numero;
        }
      }
    });

    print("Operador 1: $operador1");
    print("Operador 2: $operador2");
    print("Soma apertado: $somaApertado");
    print("Resultado: $resultado");
    print("--------------------");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Visor do resultado
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            color: Colors.black,
            child: Text(
              resultado?.toString() ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 20),
          // Teclado numérico
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Primeira linha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                    ],
                  ),
                  // Segunda linha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                    ],
                  ),
                  // Terceira linha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                    ],
                  ),
                  // Quarta linha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton("0"),
                      _buildButton("="),
                      _buildButton("+"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _pressionar(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
          minimumSize: const Size(70, 70),
        ),
        child: Text(label, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
