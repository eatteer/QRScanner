import 'dart:io';
import 'package:qrscanner/src/models/scan.dart';
export 'package:qrscanner/src/models/scan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  //INTERNAL CONSTRUCTOR INSTANCE
  static final DBProvider instance = DBProvider._internal();
  //INTERNAL CONSTRUCTOR
  DBProvider._internal();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'type TEXT,'
          'value TEXT'
          ')',
        );
      },
    );
  }

  Future<int> insert(ScanModel scan) async {
    Database db = await database;
    Future<int> res = db.insert('Scans', scan.toJson());
    return res;
  }

  Future<ScanModel> selectById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> res = await db.query(
      'Scans',
      where: 'id = ?',
      whereArgs: [id],
    );
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> selectAll() async {
    Database db = await database;
    List<Map<String, dynamic>> res = await db.query('Scans');
    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  Future<List<ScanModel>> selectByType(String type) async {
    Database db = await database;
    List<Map<String, dynamic>> res = await db.query(
      'Scans',
      where: 'type = ?',
      whereArgs: [type],
    );
    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  Future<int> update(ScanModel scan) async {
    Database db = await database;
    int res = await db.update(
      'Scans',
      scan.toJson(),
      where: 'id = ?',
      whereArgs: [scan.id],
    );
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    int res = await db.delete(
      'Scans',
      where: 'id = ?',
      whereArgs: [id],
    );
    return res;
  }

  Future<int> deleteAll() async {
    Database db = await database;
    int res = await db.delete('Scans');
    return res;
  }
}
