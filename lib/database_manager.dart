import 'package:sqflite/sqflite.dart';

import 'assignment/assignment_data.dart'; // for test

class DatabaseManager {
  final List<String> _onDBCreateSqlList;
  DatabaseManager(this._onDBCreateSqlList) {
    _init();
  }

  String? _path;
  static Database? _db;

  void _init() async {
    await _open();
    return;
  }

  _debugDropAndCreateTable(Database db, List<String> sqls) async {
    try {
      print("_debugDropAndCreateTable");
      await db.execute("DROP TABLE ${AssignmentData.tableAssignment};");
      await db.execute("DROP TABLE ${AssignmentData.tableDaily};");
    } catch (e) {
      print(e);
    }

    for (final sql in sqls) {
      try {
        await db.execute(sql);
      } catch (e) {
        print(e);
      }
    }
  }

  deleteAllInTable(String table) async {
    try {
      print("_debugDeleteTable");
      await _db!.execute("DELETE FROM ${table};");
    } catch (e) {
      print(e);
    }
  }

  _open() async {
    if (null != _db) {
      return;
    }

    if (null == _path) {
      final databasesPath = await getDatabasesPath();
      _path = databasesPath + '/assignmentData.db';
    }

    _db = await openDatabase(
      _path!,
      version: 1,
      onCreate: (Database db, int version) async {
        print("xxx openDatabase onCreate");
        // When creating the db, create the table

        // if (null != _onDBCreateSqlList) {
        for (var sql in _onDBCreateSqlList) {
          try {
            await db.execute(sql);
          } catch (e) {
            print(e);
          }
        }
        // }
      },
      onOpen: (Database db) async {
//        print("xxx openDatabase onOpen");
//        await _debugDropAndCreateTable(db, _onDBCreateSqlList); // for test

        return;
        // for test
        try {
          await db.execute("DROP TABLE ${AssignmentData.tableAssignment};");
          await db.execute(_onDBCreateSqlList[0]);
          await db.execute("DROP TABLE ${AssignmentData.tableYear};");
          await db.execute(_onDBCreateSqlList[1]);
          await db.execute("DROP TABLE ${AssignmentData.tableDaily};");
          await db.execute(_onDBCreateSqlList[2]);
        } catch (e) {
          print(e);
        }
      },
    );
    return;
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    await _open();
//    await deleteAllInTable(table);

    try {
      return _db!.insert(table, values);
    } catch (err) {
      final log = "db insert:" + err.toString();
      print(log);
      throw Exception(log);
    }
  }

  Future<int> delete(String table,
      {required String where, required List<dynamic> whereArgs}) async {
    await _open();
//    await _debugDeleteTable();
    print("db delete from ${table} ${whereArgs.toString()}");

    try {
      return _db!.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (err) {
      final log = "db delete:" + err.toString();
      print(log);
      throw Exception(log);
    }
  }

  Future<int> update(String table, Map<String, dynamic> valuePairs,
      {required String where, required List<dynamic> whereArgs}) async {
    await _open();

    try {
      return _db!.update(table, valuePairs, where: where, whereArgs: whereArgs);
//      print("updateAssignmentType res=$res");
    } catch (err) {
      final log = "db update:" + err.toString();
      print(log);
      throw Exception(log);
    }
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    required List<String> columns,
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) async {
    await _open();
    try {
      return _db!.query(table,
          columns: columns,
          where: where,
          whereArgs: whereArgs,
          orderBy: orderBy);
    } catch (err) {
      final log = "db query:" + err.toString();
      print(log);
      throw Exception(log);
    }
  }

  Batch batch() {
    return _db!.batch();
  }
}
