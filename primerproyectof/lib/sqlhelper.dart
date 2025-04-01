// import 'dart:core';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart';

// // Creamos la clase sqlhelper
// class SQLHelper {
//   // Crear las tablas
//   static Future<void> createTables(sql.Database database) async {
//     //var tablas = {
//     //"CREATE TABLE canciones(nombre TEXT);",
//     // "CREATE TABLE usuarios(id INT);",

//     //};
//     // for (String tabla in tablas) {
//     // await database.execute(tabla);
//     // }

//     await database.execute("""CREATE TABLE items(
//         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         title TEXT,
//         description TEXT,
//         createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//       )
//       """);
//   }

//   // id: the id of a item
//   // title, description: name and description of your activity
//   // created_at: the time that the item was created. It will be automatically handled by SQLite

//   // Crear la base de datos
//   static Future<sql.Database> db() async {
//     String data = await getDatabasesPath();
//     print(data);
//     return sql.openDatabase(
//       path.join(await getDatabasesPath(), 'kindacode.db'),

//       version: 1,
//       onCreate: (sql.Database database, int version) async {
//         await createTables(database);
//       },
//     );
//   }

//   // Crear item o insertar los datos
//   static Future<int> createItem(String title, String? descrption, String text, String text) async {
//     final db = await SQLHelper.db();

//     final data = {'title': title, 'description': descrption};
//     final id = await db.insert(
//       'items',
//       data,
//       conflictAlgorithm: sql.ConflictAlgorithm.replace,
//     );
//     return id;
//   }

//   // Leer todos los items
//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await SQLHelper.db();
//     return db.query('items', orderBy: "id");
//   }

//   // Read a single item by id
//   // The app doesn't use this method but I put here in case you want to see it
//   static Future<List<Map<String, dynamic>>> getItem(int id) async {
//     final db = await SQLHelper.db();
//     return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
//   }

//   // Actualizar la base de datos
//   static Future<int> updateItem(
//     int id,
//     String title,
//     String? descrption, String text, String text,
//   ) async {
//     // Instaciamos el procedimiento de la base de datos
//     final db = await SQLHelper.db();

//     final data = {
//       'title': title,
//       'description': descrption,
//       'createdAt': DateTime.now().toString(),
//     };

//     final result = await db.update(
//       'items',
//       data,
//       where: "id = ?",
//       whereArgs: [id],
//     );
//     return result;
//   }

//   // Eliminar item
//   static Future<void> deleteItem(int id) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete("items", where: "id = ?", whereArgs: [id]);
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
// }
