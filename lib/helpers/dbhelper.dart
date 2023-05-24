import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/models/contact.dart';

class DbHelper {
  static late DbHelper _dbHelper;
  static late Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper = DbHelper._createObject();
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contact.db';
    var contactDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return contactDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        """CREATE TABLE contact (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, phone TEXT)""");
  }

  Future<Database> get database async {
    _database = await initDb();
    return _database;
  }

  Future<int> insert(Contact object) async {
    Database db = await this.database;
    int count = await db.insert('contact', object.toMap());
    return count;
  }
}
