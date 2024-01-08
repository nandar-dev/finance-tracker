import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:water_reminder_app/models/note.dart';


class DatabaseHelper {
  static DatabaseHelper _dbHelper; //Singleton DatabaseHelper
  static Database _database; //Singleton Database
  String noteTable = 'password_table';
  String colPassword = 'password';
  String colId = 'id';

  DatabaseHelper._createInstance(); //named Constructor to create DatabaseHelper
  factory DatabaseHelper() {
    if (_dbHelper == null) {
      _dbHelper = DatabaseHelper
          ._createInstance(); // This is executed only one singleton object
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database;
  }

  Future<Database> initializedDatabase() async {
//    Get the directory path for both Android and IOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'note.db';

//    Open or create the database as given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY,$colPassword TEXT)');
  }

// Fetch Operaion: get all note object from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
//  var result = await db.rawQuery('SELECTE * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colId ASC');
    return result;
  }

//Insert Operation: Insert a note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    print('Insert Successfully');
    return result;
  }

//Update Operation: Update a note  object and save it to database
  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: ['1']);
    print("You Update");


    return result;
  }

//Delete Operation: Delete a note from database
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }
 Future<int> delete() async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $noteTable');
    return result;
  }
//Get Number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

//  Get the 'Map List' [List<Map>] and conver it into 'Note List' List<Note>
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();
//    for loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.formMapObjedt(noteMapList[i]));
    }
    return noteList;
  }

  Future<List> getAllNotes() async {
    var dbClient = await _database;
    var result = await dbClient.query(noteTable, columns: [
      colId,
      colPassword,
    ]);
    return result.toList();
  }
}
