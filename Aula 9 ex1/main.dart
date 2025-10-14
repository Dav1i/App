import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const double alturaBotao = 80.0;
const Color fundo = Color(0xFF1E164B);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IMCCalculadora(),
    );
  }
}

class IMCCalculadora extends StatefulWidget {
  const IMCCalculadora({super.key});

  @override
  State<IMCCalculadora> createState() => _IMCCalculadoraState();
}

class _IMCCalculadoraState extends State<IMCCalculadora> {
  double _altura = 1.50;
  int _peso = 65;
  double _imc = 0;

  void _calcularIMC() {
    setState(() {
      _imc = _peso / (_altura * _altura);
    });
  }

  void _incrementarPeso() {
    setState(() {
      _peso++;
      _calcularIMC();
    });
  }

  void _decrementarPeso() {
    setState(() {
      if (_peso > 1) _peso--;
      _calcularIMC();
    });
  }

  @override
  void initState() {
    super.initState();
    _calcularIMC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IMC')),
      body: Column(
        children: [
          // Gênero
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Caixa(
                    cor: fundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.male, color: Colors.white, size: 80.0),
                        SizedBox(height: 15),
                        Text('MASC',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Caixa(
                    cor: fundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.female, color: Colors.white, size: 80.0),
                        SizedBox(height: 15),
                        Text('FEM',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Altura
          Expanded(
            child: Caixa(
              cor: fundo,
              filho: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Altura:',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                  const SizedBox(height: 15),
                  Text('${_altura.toStringAsFixed(2)} m',
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.white)),
                  Slider(
                    value: _altura,
                    min: 1.0,
                    max: 2.2,
                    onChanged: (double novaAltura) {
                      setState(() {
                        _altura = novaAltura;
                        _calcularIMC();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Peso e Resultado
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Caixa(
                    cor: fundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Peso:',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.grey)),
                        const SizedBox(height: 15),
                        Text('$_peso kg',
                            style: const TextStyle(
                                fontSize: 24.0, color: Colors.white)),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _incrementarPeso,
                              icon: const Icon(Icons.add, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: _decrementarPeso,
                              icon:
                                  const Icon(Icons.remove, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Caixa(
                    cor: fundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Resultado:',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.grey)),
                        const SizedBox(height: 15),
                        Text(_imc.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Botão final (visual apenas)
          Container(
            color: const Color(0xFF638ED6),
            width: double.infinity,
            height: alturaBotao,
            margin: const EdgeInsets.only(top: 10.0),
            alignment: Alignment.center,
            child: const Text(
              'Calcular',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Caixa reaproveitável
class Caixa extends StatelessWidget {
  final Color cor;
  final Widget? filho;

  const Caixa({super.key, required this.cor, this.filho});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cor,
      ),
      child: filho,
    );
  }
}
