import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'money_note.dart';

class DatabaseHelperMoney {
  static DatabaseHelperMoney _databaseHelperMoney;
  static Database _database;

  String moneyNoteTable = 'money_note_table';
  String colId = 'id';
  String colMoney = 'money';
  String colDate = 'date';
  String colNumber = 'number';

  DatabaseHelperMoney._createInstance();
  

  factory DatabaseHelperMoney() {
    if (_databaseHelperMoney == null) {
      _databaseHelperMoney = DatabaseHelperMoney._createInstance();
    }
    return _databaseHelperMoney;
  }
  Future<int> deleteAll() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $moneyNoteTable');
    return result;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
   
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notey.db';
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $moneyNoteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colMoney TEXT,$colDate TEXT, $colNumber TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList(String type) async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $moneyNoteTable WHERE $colNumber = $type');
    return result;
  }


  Future<int> insertMoneyNote(MoneyNote moneynote) async {
    Database db = await this.database;
    var result = await db.insert(moneyNoteTable, moneynote.toMap());
    print("insert successful");
    return result;
  }

  Future<int> updateMoneyNote(MoneyNote moneynote) async {
    var db = await this.database;
    var result = await db.update(moneyNoteTable, moneynote.toMap(),
        where: '$colId = ?', whereArgs: [moneynote.id]);
        // Future close() async => _database.close();
      

    return result;
  }

  Future<int> deleteMoneyNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $moneyNoteTable WHERE $colId = $id');
    return result;
  }

  Future<int> deleteMoneyNote1(String type) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $moneyNoteTable WHERE $colNumber = $type');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $moneyNoteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }


  Future<List<MoneyNote>> getNoteListMoney(String type) async {
    var noteMapList = await getNoteMapList(type);
    int count = noteMapList.length;

    List<MoneyNote> noteList = List<MoneyNote>();

    for (int i = 0; i < count; i++) {
      noteList.add(MoneyNote.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future getTotal(String type) async {

    var db = await this.database;
    var result = await db.rawQuery("SELECT SUM($colMoney) as Total FROM $moneyNoteTable WHERE $colNumber = $type");
    return result;
  }

  Future getAllTotal() async {

    var db = await this.database;
    var result = await db.rawQuery("SELECT SUM($colMoney) as AllTotal FROM $moneyNoteTable");
    return result;

  }

}
