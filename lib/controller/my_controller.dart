import 'package:sqflite/sqflite.dart';

class MyController {
  static late Database database;
  List data = [];
  static initializedb() async {
    // open the database
    database = await openDatabase("my db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db
          .execute('CREATE TABLE Person (id INTEGER PRIMARY KEY, name TEXT)');
    });
  }

  AddScreen({required String name}) async {
    await database.rawInsert('INSERT INTO Person(name) VALUES(?)', [name]);
  }

  getAllData() async {
    data = await database.rawQuery('SELECT * FROM Person');
  }

  editScreen(String Newname, int id) async {
    await database
        .rawUpdate('UPDATE Person SET name = ? WHERE id = ?', [Newname, id]);
  }

  deleteScreen(int id) async {
    await database.rawDelete('DELETE FROM Person WHERE id = ?', [id]);
  }
}
