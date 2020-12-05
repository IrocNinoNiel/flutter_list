import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sql_flutter3/model/todo.dart';

class DatabaseHelper {
  final _dbName = 'dbsqlite.db';
  final _dbVersion = 1;

  final tableName = 'todo';

  final colID = 'id';
  final colTitle = 'title';
  final colStatus = 'status';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    final sql =
        'CREATE TABLE $tableName($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT NOT NULL, $colStatus BOOLEAN NOT NULL)';

    await db.execute(sql);
  }

  Future<List<Map<String, dynamic>>> getTodo() async {
    Database db = await instance.database;
    var res = await db.query(tableName, orderBy: '$colID DESC');
    return res;
  }

  Future<int> addTodo(Todo todo) async {
    Database db = await instance.database;
    var res = await db.insert(tableName, todo.toMap());
    return res;
  }

  Future<void> updateTodo(Todo todo) async {
    Database db = await instance.database;
    return await db.update(tableName, todo.toMap(),
        where: 'id = ?', whereArgs: [todo.getId()]);
  }

  Future<void> deleteTodo(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
