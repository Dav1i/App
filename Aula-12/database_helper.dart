import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _tableName = 'tarefas';

  // Define o nome das colunas do banco de dados
  static const String columnId = 'id';
  static const String columnNome = 'nome';
  static const String columnDescricao = 'descricao';
  static const String columnData = 'data';
  static const String columnConcluida = 'concluida';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tarefas.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Cria a tabela no banco de dados
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNome TEXT,
        $columnDescricao TEXT,
        $columnData TEXT,
        $columnConcluida INTEGER
      )
    ''');
  }

  // Adiciona uma nova tarefa
  Future<int> addTarefa(Map<String, dynamic> tarefa) async {
    Database db = await database;
    return await db.insert(_tableName, tarefa);
  }

  // Atualiza uma tarefa (marca como feita)
  Future<int> updateTarefa(Map<String, dynamic> tarefa, int id) async {
    Database db = await database;
    return await db
        .update(_tableName, tarefa, where: '$columnId = ?', whereArgs: [id]);
  }

  // Atualiza dados de uma tarefa
  Future<int> alterarTarefa(Map<String, dynamic> tarefa, int id) async {
    Database db = await database;
    return await db
        .update(_tableName, tarefa, where: '$columnId = ?', whereArgs: [id]);
  }

  // Busca todas as tarefas
  Future<List<Map<String, dynamic>>> getAllTarefas() async {
    Database db = await database;
    return await db.query(_tableName);
  }

  // Busca tarefas por data
  Future<List<Map<String, dynamic>>> getTarefasPorData(String data) async {
    Database db = await database;
    return await db
        .query(_tableName, where: '$columnData = ?', whereArgs: [data]);
  }
}
