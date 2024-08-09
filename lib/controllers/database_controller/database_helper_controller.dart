import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/todo_model.dart';

class DatabaseHelper {

  Database? _database;

  final String tableName = "TodoTable";
  final String id = "id";
  final String title = "title";
  final String description = "description";
  final String subject = "subject";
  final String status= "task_status";
  final String priority = "task_priority";
  final String assignedUserName = "task_assigned_userName";
  final String assignedUserId = "task_assigned_userId";
  final String deadline = "task_deadline";
  final String email = "user_email";
  final String avatar = "user_avatar";

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  Future<Database> _initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}appscrip.db';
    var db = await openDatabase(path, version: 1, onCreate: _createTable);
    return db;
  }

  Future _createTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT NOT NULL,
      $description TEXT NOT NULL,
      $subject TEXT NOT NULL,
      $status INTEGER NOT NULL,
      $priority INTEGER NOT NULL,
      $assignedUserName TEXT,
      $assignedUserId INTEGER,
      $deadline TEXT,
      $email TEXT,
      $avatar TEXT
    )
    ''');
  }

  Future<TodoModel> insertTodo(TodoModel dataModel) async {
    try {
      var db = await database;
      await db?.insert(tableName, dataModel.toJson());
      return dataModel;
    } catch(e) {
      print("Error : $e");
      return dataModel;
    }
  }

  Future<List<TodoModel>> viewData() async {
    try {
      var db = await database;
      final List<Map<String, dynamic>> queryResult = await db!.query(tableName);

      return queryResult.map((e) => TodoModel.fromJson(e)).toList();
    } catch(e) {
      print("Error : $e");
      return [];
    }
  }

  Future<int> updateTodoList(TodoModel dataModel) async {
    try {
      var db = await database;
      return db!.update(tableName, dataModel.toJson(), where: '$id = ?', whereArgs: [dataModel.id]);
    } catch(e) {
      print("Error : $e");
      return 0;
    }
  }

  Future<int?> delete(int id) async {
    try {
      var db = await database;
    return await  db?.rawDelete("delete from $tableName where id=$id");

      // return await db?.delete(tableName, where: '$id = ?', whereArgs: [id]) ?? 0;
    } catch(e) {
      print("Error : $e");
      return 0;
    }
  }
}
