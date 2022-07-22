import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      print("check database has initilized");
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Creating Database");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING, note TEXT ,date STRING,"
            "startTime STRING,endTime STRING,"
            "remind INTEGER,repeat STRING,"
            "color INTEGER,"
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async{
    print("Insert Function calling");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  static Future<List<Map<String,dynamic>>> query() async{
    print("Query Function called");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async{
    print("Delete Query called");
    await _db!.delete(_tableName,where:'id=?',whereArgs: [task.id] );
  }

  static update(int id) async{
    print("Update Query called");
   return await _db!.rawUpdate(
      '''
      UPDATE $_tableName
      SET isCompleted =?
      WHERE id=?
      ''',[1,id]
    );
  }
}
