import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TodoItem{
  int userId;
  int id;
  String title;
  String completed;

  TodoItem({required this.userId,required this.id,required this.title,required this.completed});

  factory TodoItem.fromMap(Map<String,dynamic>json) => TodoItem(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed']);

  Map<String,dynamic> toJson(){
    return {
      'userId': userId,
      'id':id,
      'title':title,
      'completed': completed,
    };
  }
}

class DatabaseHelper{

  DatabaseHelper._privateconstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateconstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'TodoItem.db');
    return await openDatabase(
        path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('CREATE TABLE todo_items(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, completed INTEGER)');
  }

  Future<List<TodoItem>> getTodoItem() async{
    Database db = await instance.database;
    var TodoItems = await db.query('todo_items',orderBy: 'id');
    List<TodoItem> TodoItemsList = TodoItems.isNotEmpty ? TodoItems.map((c) => TodoItem.fromMap((c))).toList() : [] ;
    return TodoItemsList;
  }

  Future<int> add(TodoItem todoItem1) async{
    Database db = await instance.database;
    return await db.insert('todo_items', todoItem1.toJson());
  }
  Future<int> remove(int id) async{
    Database db = await instance.database;
    return await db.delete('todo_items',where: 'id = ?', whereArgs: [id]);
  }
  Future<int> update(TodoItem todoItem2,int id) async{
    Database db = await instance.database;
    return await db.update('todo_items', todoItem2.toJson(),where: 'id = ?', whereArgs: [id]);
  }
}