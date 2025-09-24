import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model_pergunta.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _indiceAtual = 0;
  int _pontuacao = 0;
  bool _respondido = false;
  int? _respostaSelecionada;

  @override
  void initState() {
    super.initState();
    _loadEstado();
  }

  Future<void> _loadEstado() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _indiceAtual = prefs.getInt('quiz_indiceAtual') ?? 0;
      _pontuacao = prefs.getInt('quiz_pontuacao') ?? 0;
    });
  }

  Future<void> _salvarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quiz_indiceAtual', _indiceAtual);
    await prefs.setInt('quiz_pontuacao', _pontuacao);
  }

  void _responder(int idx) {
    if (_respondido) return;
    setState(() {
      _respondido = true;
      _respostaSelecionada = idx;
      if (idx == perguntas[_indiceAtual].indiceCorreto) {
        _pontuacao++;
      }
    });
    _salvarEstado();
  }

  void _proximaPergunta() {
    if (_indiceAtual < perguntas.length - 1) {
      setState(() {
        _indiceAtual++;
        _respondido = false;
        _respostaSelecionada = null;
      });
      _salvarEstado();
    } else {
      _mostrarResultado();
    }
  }

  void _mostrarResultado() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Fim do Quiz!'),
        content: Text('Sua pontuação: $_pontuacao / ${perguntas.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _indiceAtual = 0;
                _pontuacao = 0;
                _respondido = false;
                _respostaSelecionada = null;
              });
              _salvarEstado();
            },
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = perguntas[_indiceAtual];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz de Conhecimentos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Pergunta ${_indiceAtual + 1}/${perguntas.length}'),
            const SizedBox(height: 16),
            Text(pergunta.enunciado, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...List.generate(pergunta.alternativas.length, (i) {
              final alt = pergunta.alternativas[i];
              final isCorreta = i == pergunta.indiceCorreto;
              final selecionada = _respostaSelecionada == i;

              Color cor;
              if (_respondido) {
                if (selecionada) {
                  cor = isCorreta ? Colors.green : Colors.red;
                } else if (isCorreta) {
                  cor = Colors.green;
                } else {
                  cor = Colors.grey.shade300;
                }
              } else {
                cor = Colors.blue.shade100;
              }

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cor,
                    foregroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => _responder(i),
                  child: Text(alt),
                ),
              );
            }),
            const Spacer(),
            if (_respondido)
              ElevatedButton(
                onPressed: _proximaPergunta,
                child: Text(_indiceAtual < perguntas.length - 1
                    ? 'Próxima'
                    : 'Finalizar'),
              ),
          ],
        ),
      ),
    );
  }
}
