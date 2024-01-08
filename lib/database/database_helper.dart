import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'note.dart';

class DatabaseHelper1 {
  static DatabaseHelper1 _databasseHelper;
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPrice = 'price';
  String colTotal = 'total';

  DatabaseHelper1._createInstance();

  factory DatabaseHelper1() {
    if (_databasseHelper == null) {
      _databasseHelper = DatabaseHelper1._createInstance();
    }
    return _databasseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + 'notese.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colPrice TEXT, $colTotal TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colId ASC');
    return result;
  }

  Future<int> insertNote(Note2 note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note2 note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);

    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  Future<int> deleteAll() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note2>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note2> noteList = List<Note2>();

    for (int i = 0; i < count; i++) {
      noteList.add(Note2.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<int> updateTotal(String id, String total) async {
    var db = await this.database;
    int result = await db.rawUpdate(
        'UPDATE $noteTable SET $colTotal = $total WHERE $colId = $id');
    print("update Total Successfully");
    return result;
  }

  Future getAllTotal() async {
    var db = await this.database;
    var result =
        await db.rawQuery("SELECT SUM($colTotal) as AllTotal FROM $noteTable");
    return result;
  }
}
