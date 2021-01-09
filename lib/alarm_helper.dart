import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/alarm_model.dart';

final String tableName = 'AlarmTable';

class AlarmHelper {
  AlarmHelper._();
  static final AlarmHelper _db = AlarmHelper._();
  factory AlarmHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'alarmappDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $tableName(id INTEGER PRIMARY KEY, alarmDateTime TEXT, isPending INTEGER, mon INTEGER, tue INTEGER, wed INTEGER, thu INTEGER, fri INTEGER, sat INTEGER, sun INTEGER)');
      },
    );
  }

  //Create
  createAlarm(Alarm alarm) async {
    final db = await database;
    var res = await db.insert(
        tableName,
        alarm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
    print("createAlarm");
    return res;
  }

  // READ
  getAlarm(int id) async {
    final db = await database;
    var res = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    print("res: ${res}");
    Alarm dumAlarm = new Alarm(
      id: -1,
      alarmDateTime: DateTime.now(),
      isPending: 0,
      mon: 0,
      tue: 0,
      wed: 0,
      thu: 0,
      fri: 0,
      sat: 0,
      sun: 0
    );
    return res.isNotEmpty ? Alarm.fromMap(res.first) : dumAlarm;
  }

  // READ ALL DATA
  getAllAlarm() async {
    final db = await database;
    var res = await db.query(tableName);
    List<Alarm> list =
        res.isNotEmpty ? res.map((c) => Alarm.fromMap(c)).toList() : [];
    print("list: ${list}");
    return list;
  }

  // Update Alarm
  updateAlarm(Alarm alarm) async {
    final db = await database;
    var res = await db.update(tableName, alarm.toMap(),
        where: 'id = ?', whereArgs: [alarm.id]);
    print("updateAlarm");
    return res;
  }

  // Delete Alarm
  deleteAlarm(int id) async {
    final db = await database;
    db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  // Delete All Alarm
  deleteAllAlarm() async {
    final db = await database;
    db.rawDelete('Delete * from $tableName');
  }
}
