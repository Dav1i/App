import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabuadaPage extends StatefulWidget {
  @override
  State<TabuadaPage> createState() => _TabuadaPageState();
}

class _TabuadaPageState extends State<TabuadaPage> {
  int _tabuada = 1;
  int _multiplicando = 1;
  int _acertos = 0;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarEstado();
  }

  Future<void> _carregarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tabuada = prefs.getInt('tabuada_tabuada') ?? 1;
      _multiplicando = prefs.getInt('tabuada_multiplicando') ?? 1;
      _acertos = prefs.getInt('tabuada_acertos') ?? 0;
    });
  }

  Future<void> _salvarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tabuada_tabuada', _tabuada);
    await prefs.setInt('tabuada_multiplicando', _multiplicando);
    await prefs.setInt('tabuada_acertos', _acertos);
  }

  void _verificarResposta() {
    final resposta = int.tryParse(_controller.text);
    final resultadoCorreto = _tabuada * _multiplicando;

    if (resposta == resultadoCorreto) {
      _acertos++;
      _multiplicando++;

      if (_multiplicando > 10) {
        _multiplicando = 1;
        _tabuada++;
        if (_tabuada > 10) {
          _mostrarConclusao();
          return;
        }
      }
    }

    _controller.clear();
    _salvarEstado();
    setState(() {});
  }

  void _mostrarConclusao() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Parabéns!'),
        content: Text(
            'Você completou a tabuada do 1 ao 10!\nTotal de acertos: $_acertos'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetar();
            },
            child: const Text('Recomeçar'),
          ),
        ],
      ),
    );
  }

  void _resetar() async {
    _tabuada = 1;
    _multiplicando = 1;
    _acertos = 0;
    await _salvarEstado();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Treino de Tabuada')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Quanto é $_tabuada x $_multiplicando?',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sua resposta',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _verificarResposta(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verificarResposta,
              child: const Text('Responder'),
            ),
            const Spacer(),
            Text('Acertos: $_acertos'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _resetar,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Reiniciar Tabuada'),
            ),
          ],
        ),
      ),
    );
  }
}
