import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TarefasScreen(),
    );
  }
}

class TarefasScreen extends StatefulWidget {
  @override
  _TarefasScreenState createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  final _dbHelper = DatabaseHelper();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataController = TextEditingController();

  List<Map<String, dynamic>> _tarefas = [];

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  // Carregar todas as tarefas
  Future<void> _carregarTarefas() async {
    final tarefas = await _dbHelper.getAllTarefas();
    setState(() {
      _tarefas = tarefas;
    });
  }

  // Adicionar tarefa
  Future<void> _adicionarTarefa() async {
    if (_nomeController.text.isEmpty ||
        _descricaoController.text.isEmpty ||
        _dataController.text.isEmpty) {
      return;
    }

    final tarefa = {
      'nome': _nomeController.text,
      'descricao': _descricaoController.text,
      'data': _dataController.text,
      'concluida': 0, // 0 significa não concluída
    };

    await _dbHelper.addTarefa(tarefa);
    _nomeController.clear();
    _descricaoController.clear();
    _dataController.clear();
    _carregarTarefas();
  }

  // Alterar tarefa (marcar como concluída)
  Future<void> _marcarComoConcluida(int id) async {
    final tarefa = {
      'concluida': 1, // 1 significa concluída
    };

    await _dbHelper.updateTarefa(tarefa, id);
    _carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome da Tarefa'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data (YYYY-MM-DD)'),
            ),
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: Text('Adicionar Tarefa'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = _tarefas[index];
                  return ListTile(
                    title: Text(tarefa['nome']),
                    subtitle: Text(tarefa['descricao']),
                    trailing: Checkbox(
                      value: tarefa['concluida'] == 1,
                      onChanged: (bool? value) {
                        _marcarComoConcluida(tarefa['id']);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
