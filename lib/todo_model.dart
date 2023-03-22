import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';



class TodoItem{

  int id;
  String name;
  int age;
  String birthdate;
  String address;
  String hobbies;
  Uint8List? imagePath;


  TodoItem({required this.id,required this.name,required this.age,required this.birthdate,required this.address,
  required this.hobbies,this.imagePath,});


  factory TodoItem.fromMap(Map<String,dynamic>json) => TodoItem(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      birthdate: json['birthdate'],
      address: json['address'],
      hobbies: json['hobbies'],
      imagePath: json['imagePath'],
  );


  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name': name,
      'age': age,
      'birthdate': birthdate,
      'address': address,
      'hobbies': hobbies,
      'imagePath': imagePath,
    };
  }
}




class Images{
  static const String asset = 'assets/';
  static const frontLogo = '${asset}aboutme.png';
  static const frontLogo1 = '${asset}mobilesign.png';
  static const frontLogo2 = '${asset}aboutmelogin1.png';
}




class DatabaseHelper{


  DatabaseHelper._privateconstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateconstructor();

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static Map<String, Database> _databases = {};

  Future<Database> get database async {
    String uid = auth.currentUser!.uid;
    if (_databases[uid] == null) {
      _databases[uid] = await _initDatabase(uid);
    }
    return _databases[uid]!;
  }

  Future<Database> _initDatabase(String uid) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'TodoItem_$uid.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo_items(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, birthdate TEXT, address TEXT, hobbies TEXT, imagePath BLOB)');
  }

  Future<List<TodoItem>> getTodoItems() async {
    Database db = await instance.database;
    var todoItems = await db.query('todo_items', orderBy: 'id');
    List<TodoItem> todoItemsList = todoItems.isNotEmpty
        ? todoItems.map((c) => TodoItem.fromMap(c)).toList()
        : [];
    return todoItemsList;
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


