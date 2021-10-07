import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBMS {
  static final db = 'db1.db';
  static final version = 1;

// The table parts
  static final tableName = 'tradebook';
  static final id = 'id';
  static final scrip = 'scrip';
  static final entry = 'entry';
  static final qty = 'qty';
  static final bs = 'buyorsell'; //if 1 buy elif 0 sell
  static final ls = 'longorshort'; // if 1 long elif 0 short

// make the class a singleton class
  DBMS._private();
  static final DBMS instance = DBMS._private();

  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB();
    }
  }

// Init the db if it doesn't already exist in the device
  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, db);
    return await openDatabase(path, version: version, onCreate: _populateDB);
  }

  Future _populateDB(Database db, int version) async {
    db.query('''
    CREATE TABLE $tableName (
      $id INTEGER AUTO_INCREMENT PRIMARY KEY ,
      $entry DOUBLE NOT NULL,
      $scrip TEXT NOT NULL,
      $qty DOUBLE NOT NULL,
      $bs INTEGER NOT NULL,
      $ls INTEGER NOT NULL )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = instance._database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> fetch() async {
    Database db = instance._database;
    return await db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = instance._database;
    return await db
        .update(tableName, row, where: '$id = ?', whereArgs: [row[id]]);
  }

  Future<int> delete(int id) async {
    Database db = instance._database;
    return await db.delete(tableName, where: '$id = ?', whereArgs: [id]);
  }
}
