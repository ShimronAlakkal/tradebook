import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class Helper {
  static final String db = 'info.db';
  static final String table = 'infoTable';
  static final String id = 'id';
  static final String symbol = 'symbol';
  static final String qty = 'Qty';
  static final String enterPrice = 'Enter';
  static final String exitPrice = 'exit';
  static final String dateEntered = 'dateOfEntering';
  static final String exitDate = 'ExitDate';
  static final String currentPriceOnDayEnd = 'DayEndPrice';
  static final String target = 'targetPrice';
  static final String position = 'position';

  Helper._private();
  static final Helper dbInstance = Helper._private();

  static Database _database;

  Future get initDatabase async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _createDb();
      return _database;
    }
  }

  Future _createDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(
      directory.path,
      db,
    );
    return await openDatabase(
      path,
      onCreate: _populateDb,
      version: 1,
    );
  }

  _populateDb(Database db, int version) async {
    return await db.execute('''
      CREATE TABLE IF NOT EXISTS $table(
        $id integer PRIMARY KEY AUTOINCREMENT,
        $symbol TEXT,
        $enterPrice  NUMERIC ,
        $dateEntered DATE ,
        $position  INTEGER ,
        $qty NUMERIC ,
        $target NUMERIC ,
        $exitDate DATE,
        $currentPriceOnDayEnd NUMERIC,
        $exitPrice NUMERIC
      )
      ''');
  }

  Future insert(Map<String, dynamic> row) async {
    Database db = await dbInstance.initDatabase;
    return await db.insert(table, row);
  }

  Future select() async {
    Database db = await dbInstance.initDatabase;
    return await db.query(table);
  }

  Future update(Map<String, dynamic> row) async {
    Database db = await dbInstance.initDatabase;
    return await db.update(
      table,
      row,
      where: '$id = ?',
      whereArgs: [
        row[id],
      ],
    );
  }

  Future delete(int id) async {
    Database db = await dbInstance.initDatabase;
    return await db.delete(
      table,
      where: '$id = ?',
      whereArgs: [
        id,
      ],
    );
  }
}
