import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './models/todo_model.dart'; 

class DatabaseHelper {
  final String _dbName = 'todoApp.db';
  final int _dbVersion = 1;
  final String _tableName = 'todos';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task TEXT NOT NULL,
        isCompleted INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insert(Todo todo) async {
    Database db = await database;
    return await db.insert(_tableName, todo.toJson());
  }

  Future<List<Todo>> getAllTodos() async {
    Database db = await database;
    final List<Map<String, dynamic>> todoMaps = await db.query(_tableName);
    return List.generate(todoMaps.length, (i) {
      return Todo.fromJson(todoMaps[i]);
    });
  }

  Future<int> update(Todo todo) async {
    Database db = await database;
    return await db.update(_tableName, todo.toJson(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
