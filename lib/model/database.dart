// @dart=2.9

// ignore_for_file: prefer_const_declarations
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbase {
  static final db = 'trades.db';
  static final version = 1;

// The table for trades
  static final tradesTable = 'tradebook';
  static final id = 'id';
  static final scrip = 'scrip';
  static const date = 'date';

  static final entry = 'entry';
  static final qty = 'qty';
  static final sl = 'sl';
  static final bs = 'buyorsell'; //if 1 buy elif 0 sell
  static final ls = 'longorshort'; // 0 = intraday , 1 = swing , 2 = delivery

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
      return _database;
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
    return await db.execute('''
    CREATE TABLE $tradesTable (
      $id INTEGER PRIMARY KEY AUTOINCREMENT ,
      $entry DOUBLE NOT NULL,
      $date TEXT NOT NULL,
      $sl DOUBLE NULL,
      $scrip TEXT NOT NULL,
      $qty DOUBLE NOT NULL,
      $bs INTEGER NOT NULL,
      $ls INTEGER NOT NULL )
    ''');
  }

  Future<int> insertToTrades(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(tradesTable, row);
  }

  Future<List<Map<String, dynamic>>> fetchTrades() async {
    Database db = await database;
    return await db.query(tradesTable);
  }

  Future<int> updateTrade(Map<String, dynamic> row, int cid) async {
    Database db = await database;
    return await db.rawUpdate(''' 
        UPDATE $tradesTable SET 
        entry = ${row['entry']} ,
        date = ${row['date']},
        scrip = "${row['scrip']}",
        qty = ${row['qty']},
        buyorsell = ${row['buyorsell']},
        longorshort = ${row['longorshort']},
        sl = ${row['sl']}
        WHERE $id = $cid 
        ''');
  }

  Future<int> deleteTrade(int id) async {
    Database db = await database;
    return await db.rawDelete('DELETE FROM $tradesTable WHERE id = $id');
  }

  Future<double> getTotalInvestment() async {
    Database db = await database;
    var data = await db.rawQuery('''
  SELECT SUM(entry*qty) FROM $tradesTable WHERE buyorsell = 1;
  ''');
    if (data[0]['SUM(entry*qty)'] != 'null' ||
        data[0]['SUM(entry*qty)'] != null) {
      return data[0]['SUM(entry*qty)'];
    } else {
      return 0.0;
    }
  }
}
