import 'dart:async' as prefix0;

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:water_reminder_app/models/note.dart';
import 'package:water_reminder_app/models/note1.dart';

class DatabaseCome {
  static DatabaseCome _databasecome; //Singleton DatabaseHelper
  static Database _database; //Singleton Database
  String comeTable = 'come_table';
  String colId = 'id';

  String colSalary = 'salary';

  String colIncomeAmount = 'incomeamount';

  String colOutcomeAmount = 'outcomeamount';

  String colNote = 'note';

  String colDate = 'date';

  String colCome = 'come';

  String colDay = 'day';

  DatabaseCome._createInstance();

  factory DatabaseCome() {
    if (_databasecome == null) {
      _databasecome = DatabaseCome
          ._createInstance(); //This is executed only once, sigleton object
    }
    return _databasecome;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    //Get the director path for both Android and iO to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $comeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT , $colSalary TEXT , $colIncomeAmount TEXT,$colOutcomeAmount TEXT,$colNote TEXT,$colDate TEXT, $colCome TEXT ,$colDay INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    // var result= await db.rawQuery('SELECT * FROM $signin order by $colno ASC');
    var result = await db.query(comeTable, orderBy: '$colId DESC');
    return result;
  }

  Future<List<Note3>> getMonth(int from, int to) async {
    var noteMapList = await getMonthlyList(from, to);
    int count = noteMapList.length;
    List<Note3> noteList = List<Note3>();

    for (int i = 0; i < count; i++) {
      noteList.add(Note3.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<Note3>> soesantun() async {
    var noteMapList = await getIncome();
    int count = noteMapList.length;
    List<Note3> noteList = List<Note3>();

    for (int i = 0; i < count; i++) {
      noteList.add(Note3.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<Note3>> getOutcome() async {
    var noteMapList = await getoutcome();
    int count = noteMapList.length;
    List<Note3> noteList = List<Note3>();

    for (int i = 0; i < count; i++) {
      noteList.add(Note3.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<Map<String, dynamic>>> getIncome() async {
    Database db = await database;
    var result = await db
        .rawQuery("SELECT * FROM $comeTable WHERE $colOutcomeAmount = 0");
    return result;
  }

  Future<List<Map<String, dynamic>>> getMonthlyList(int from, int to) async {
    Database db = await database;
    var result = await db.rawQuery(
        "SELECT * FROM $comeTable WHERE $colDay BETWEEN $from and $to");

    return result;
  }
  // Future<List<Map<String, dynamic>>> getMonthlyList() async {
  //   Database db = await database;
  //   var result = await db.rawQuery(
  //       "SELECT * FROM $comeTable WHERE $colDay BETWEEN 739381 and 739383");

  //   return result;
  // }

  Future<List<Map<String, dynamic>>> getoutcome() async {
    Database db = await database;
    var result = await db
        .rawQuery("SELECT * FROM $comeTable WHERE $colIncomeAmount = 0");
    return result;
  }

  Future<int> insertNote(Note3 note) async {
    Database db = await this.database;
    var result = await db.insert(comeTable, note.toMap());
    print('successful');
    return result;
  }

  Future<int> updateNote(Note3 note) async {
    Database db = await this.database;
    var result = await db.update(comeTable, note.toMap(),
        where: '$colId=?', whereArgs: [note.id]);

    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $comeTable WHERE $colId = $id');
    return result;
  }

  Future<int> deleteAll() async {
    print("deleteAll");
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $comeTable');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $comeTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note3>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note3> noteList = List<Note3>();

    for (int i = 0; i < count; i++) {
      noteList.add(Note3.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<Note3>> getIncomeList(String income) async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note3> noteList = List<Note3>();

    for (int i = 0; i < count; i++) {
      noteList.add(Note3.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<List> getAllNotes() async {
    var dbClient = await _database;
    var result = await dbClient.query(comeTable, columns: [
      colId,
      colSalary,
      colIncomeAmount,
      colOutcomeAmount,
      colNote,
      colDate,
      colCome,
    ]);
    return result.toList();
  }


 Future totalFromIncome(int from, int to) async {
    var db = await this.database;
    var result = await db
        .rawQuery("SELECT SUM($colIncomeAmount) as Total FROM $comeTable WHERE $colDay BETWEEN $from and $to");
    return result;
  }

   Future totalToIncome(int from, int to) async {
    var db = await this.database;
    var result = await db
        .rawQuery("SELECT SUM($colOutcomeAmount) as Total FROM $comeTable WHERE $colDay BETWEEN $from and $to");
    return result;
  }
  Future totalIncome() async {
    var db = await this.database;
    var result = await db
        .rawQuery("SELECT SUM($colIncomeAmount) as Total FROM $comeTable");
    return result;
  }

  Future totalOutcome() async {
    var db = await this.database;
    var result = await db
        .rawQuery("SELECT SUM($colOutcomeAmount) as Total FROM $comeTable");
    return result;
  }

  Future totalcomein() async {
    var db = await this.database;
    var result = await db.rawQuery(
        "SELECT SUM($colIncomeAmount) as Total FROM $comeTable Between $colDate  ");
    return result;
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + 'notes.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  Future totalincome() async {
    var db = await this.database;
    var result =
        await db.rawQuery("SELECT * FROM $comeTable WHERE $colCome = income");
    return result;
  }

//   Future<List<Note3>> getmenuList(String type) async{
//     var noteMapList = await getAllrecord(type);
//     int count  = noteMapList.length;
//     List<Note3> noteList = List<Note3>();
//     for( int i =0; i<count ;i++){
//       noteList.add(Note3.fromMapObject(noteMapList[i]));
//     }
//     return noteList;
//   }

//  Future<List> getAllrecord(String type) async{
//     var dbClient = _database;
//     var result = await dbClient
//     .rawQuery("SELECT * FROM $comeTable WHERE $colCome == $type");
//     return result.toList();
//   }

}
