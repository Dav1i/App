import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('calculadora.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dados (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numeroAtual REAL,
        memoria REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE operacoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expressao TEXT,
        resultado REAL,
        data TEXT
      )
    ''');

    // inicializa os dados
    await db.insert('dados', {'numeroAtual': 0, 'memoria': 0});
  }

  // Atualiza dados da calculadora
  Future<void> atualizarDados(double numeroAtual, double memoria) async {
    final db = await instance.database;
    await db.update(
      'dados',
      {'numeroAtual': numeroAtual, 'memoria': memoria},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<Map<String, dynamic>> lerDados() async {
    final db = await instance.database;
    final result = await db.query('dados', where: 'id = ?', whereArgs: [1]);
    return result.first;
  }

  Future<void> salvarOperacao(String expressao, double resultado) async {
    final db = await instance.database;
    await db.insert('operacoes', {
      'expressao': expressao,
      'resultado': resultado,
      'data': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> listarOperacoes() async {
    final db = await instance.database;
    return await db.query('operacoes', orderBy: 'id DESC');
  }
}
