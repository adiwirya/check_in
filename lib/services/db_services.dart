import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBServices {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'checkin.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_records(id TEXT PRIMARY KEY, location TEXT, dates TEXT, checks TEXT, times TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBServices.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBServices.database();
    return db.query(table);
  }
}
