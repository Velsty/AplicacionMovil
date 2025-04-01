import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';



// Creamos la clase sqlhelper
class SQLHelper {
  // Crear las tablas
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        fechapublicacion TEXT,
        precio TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  // Crear la base de datos
  static Future<sql.Database> db() async {
    String data = await getDatabasesPath();
    print(data);
    return sql.openDatabase(
      path.join(await getDatabasesPath(), 'bookstore.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Crear item o insertar los datos
  static Future<int> createItem(
    String title, 
    String? description, 
    String? fechapublicacion, 
    String? precio
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title, 
      'description': description, 
      'fechapublicacion': fechapublicacion, 
      'precio': precio
    };
    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  // Leer todos los items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Leer un solo item por id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Actualizar la base de datos
  static Future<int> updateItem(
    int id,
    String title, 
    String? description,
    String? fechapublicacion, 
    String? precio
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title, 
      'description': description, 
      'fechapublicacion': fechapublicacion, 
      'precio': precio,
      'createdAt': DateTime.now().toString()
    };

    final result = await db.update(
      'items',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  // Eliminar item
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo salió mal al eliminar un item: $err");
    }
  }
}
