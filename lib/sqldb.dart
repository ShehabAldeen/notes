import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    }
    return _db;
  }

  intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "wael.db");
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("ALTER TABLE 'notes' ADD COLUMN color TEXT");
    debugPrint('upgrade---------------');
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
   CREATE TABLE "notes" (
   "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
   "title" TEXT NOT NULL,
   "note" TEXT NOT NULL,
   "color" TEXT NOT NULL,
   )
   ''');
    await batch.commit();
    print('----------created');
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  deleteDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "wael.db");
    await deleteDatabase(path);
  }
}
