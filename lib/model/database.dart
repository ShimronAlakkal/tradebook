import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbase {
  static final db = 'db1.db';
  static final version = 1;

// The table for trades
  static final tradesTable = 'tradebook';
  static final id = 'id';
  static final scrip = 'scrip';
  static final entry = 'entry';
  static final qty = 'qty';
  static final bs = 'buyorsell'; //if 1 buy elif 0 sell
  static final ls = 'longorshort'; // if 1 long elif 0 short

  // The table for
  static final transactionTable = 'transactions';
  static final date = 'date';
  static final amount = 'amount';
  static final type = 'type'; // 1 = deposit  , 0 = withdraw

// make the class a singleton class
  Dbase._privateConstructor();
  static final Dbase instance = Dbase._privateConstructor();

  Database _database;
  Future get database async {
    // ignore: unnecessary_null_comparison
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
    // Creating a database for the main notes
    db.query('''
    CREATE TABLE $tradesTable (
      $id INTEGER AUTO_INCREMENT PRIMARY KEY ,
      $entry DOUBLE NOT NULL,
      $scrip TEXT NOT NULL,
      $qty DOUBLE NOT NULL,
      $bs INTEGER NOT NULL,
      $ls INTEGER NOT NULL )
    ''');

    // Ceating the table for money transatcionc
    db.query('''
      CREATE TABLE $tradesTable (
        $id  INTEGER AUTO_INCREMENT PRIMARY KEY ,
        $amount DOUBLE NOT NULL,
        $date DATE NOT NULL,
        $type INTEGER NOT NULL,
      )
      ''');
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = instance._database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> fetch(String table) async {
    Database db = instance._database;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row, String table, int id) async {
    Database db = instance._database;
    return await db.update(table, row, where: '$id = ?', whereArgs: [row[id]]);
  }

  Future<int> delete(int id, String table) async {
    Database db = instance._database;
    return await db.delete(table, where: '$id = ?', whereArgs: [id]);
  }
}
