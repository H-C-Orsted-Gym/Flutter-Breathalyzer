import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Tracking {
  static final _dbName = "database.db";
  static final _dbVersion = 1;
  static final tableName = "Trackings";
  static final columnId = "Id";
  static final columnDate = "DateTracked";
  static final columnData = "DataTracked";

  Tracking._privateConstructor();
  static final Tracking instance = Tracking._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.rawQuery("""
              CREATE TABLE ${tableName} (
                ${columnId} INTEGER PRIMARY KEY,
                ${columnDate} varchar(255),
                ${columnData} varchar(255)
              );
      """);
  }

  Future<int> insert(String data, String date) async {
    Database db = await instance.database;

    db.execute("INSERT INTO ${tableName} (${columnData}, ${columnDate}) VALUES ('${data}', '${date}');");
  }

  void delete(int id) async {
    Database db = await instance.database;
    db.execute("DELETE FROM ${tableName} WHERE ${columnId}=${id}");
  }

  void deleteAllRecords() async {
    Database db = await instance.database;
    db.execute("DELETE FROM ${tableName}");
  }

  Future<List<Map<String, Object>>> getRecords() async {
    Database db = await instance.database;

    List<Map<String, Object>> result = await db.rawQuery("SELECT * FROM ${tableName} ORDER BY Id ASC");

    return result;
  }

  Future<List<Map<String, Object>>> getLatestSample() async {
    Database db = await instance.database;

    List<Map<String, Object>> result = await db.rawQuery("SELECT * FROM ${tableName} ORDER BY Id DESC LIMIT 1");
    //double sampleResult = double.parse(result[0]["Data"]);

    return result;
  }

  Future<List<Map<String, Object>>> getDailyRecords() async {
    Database db = await instance.database;

    String date = DateFormat('dd/MM/yyyy').format(DateTime.now());

    print(date);

    List<Map<String, Object>> result = await db.rawQuery("SELECT * FROM ${tableName} WHERE ${columnDate} LIKE '%${date}%';");

    return result;
  }
}
