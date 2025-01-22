import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;

  DatabaseProvider._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');

    if (!await File(path).exists()) {
      final data = await rootBundle.load('assets/database/database.db');
      final bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);
    }

    final db = await openDatabase(path);

    // Verificar columnas de la tabla 'projects'
    final columns = await db.rawQuery('PRAGMA table_info(projects);');
    print('Columnas en la tabla projects:');
    for (var column in columns) {
      print('Nombre: ${column['name']}, Tipo: ${column['type']}');
    }

    return db;
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<void> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(String table, Map<String, dynamic> values, String where,
      List<Object?> whereArgs) async {
    final db = await database;
    await db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<void> delete(
      String table, String where, List<Object?> whereArgs) async {
    final db = await database;
    await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
}
