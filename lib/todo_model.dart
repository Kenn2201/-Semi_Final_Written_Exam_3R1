import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TodoItem{

  int id;

  String name;
  int age;
  String birthdate;
  String address;
  String hobbies;
  String? imagePath;


  TodoItem({required this.id,required this.name,required this.age,required this.birthdate,required this.address,
  required this.hobbies,this.imagePath,});

  factory TodoItem.fromMap(Map<String,dynamic>json) => TodoItem(
      id: json['id'],

      name: json['name'],
      age: json['age'],
      birthdate: json['birthdate'],
      address: json['address'],
      hobbies: json['hobbies'],

  );

  Map<String,dynamic> toJson(){
    return {
      'id':id,

      'name': name,
      'age': age,
      'birthdate': birthdate,
      'address': address,
      'hobbies': hobbies,

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
    await db.execute('CREATE TABLE todo_items(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, birthdate TEXT, address TEXT, hobbies TEXT)');
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