// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:water_reminder_app/database/noteorder.dart';

// class DatabaseHelperorder {
//   static DatabaseHelperorder _databasseHelper;
//   static Database _database;

//   String orderTable = 'order_table';
//   String colId = 'id';
//   String colTitle = 'title';

//   DatabaseHelperorder._createInstance();

//   factory DatabaseHelperorder() {
//     if (_databasseHelper == null) {
//       _databasseHelper = DatabaseHelperorder._createInstance();
//     }
//     return _databasseHelper;
//   }

//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await initalizeDatabase();
//     }
//     return _database;
//   }

//   Future<Database> initalizeDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();

//     String path = directory.path + 'notese11.db';

//     var notesDatabase =
//         await openDatabase(path, version: 1, onCreate: _createDb);
//     return notesDatabase;
//   }

//   void _createDb(Database db, int newVersion) async {
//     await db.execute(
//         'CREATE TABLE $orderTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT)');
//   }

//   Future<List<Map<String, dynamic>>> getNoteMapList() async {
//     Database db = await this.database;

//     // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
//     var result = await db.query(orderTable, orderBy: '$colId DESC');
//     return result;
//   }

//   Future<int> insertNote(Noteorder note) async {
//     print("successful");
//     Database db = await this.database;
//     var result = await db.insert(orderTable, note.toMap());
//     return result;
//   }

//   Future<int> updateNote(Noteorder note) async {
//     var db = await this.database;
//     var result = await db.update(orderTable, note.toMap(),
//         where: '$colId = ?', whereArgs: [note.id]);

//     return result;
//   }

//   Future<int> deleteNote(int id) async {
//     var db = await this.database;
//     int result =
//         await db.rawDelete('DELETE FROM $orderTable WHERE $colId = $id');
//     return result;
//   }

//   Future<int> deleteAll() async {
//     var db = await this.database;
//     int result = await db.rawDelete('DELETE FROM $orderTable');
//     return result;
//   }

//   Future<int> getCount() async {
//     Database db = await this.database;
//     List<Map<String, dynamic>> x =
//         await db.rawQuery('SELECT COUNT (*) from $orderTable');
//     int result = Sqflite.firstIntValue(x);
//     return result;
//   }

//   Future<List<Noteorder>> getNoteList() async {
//     var noteMapList = await getNoteMapList();
//     int count = noteMapList.length;

//     List<Noteorder> noteList = List<Noteorder>();

//     for (int i = 0; i < count; i++) {
//       noteList.add(Noteorder.fromMapObject(noteMapList[i]));
//     }
//     return noteList;
//   }
// }
