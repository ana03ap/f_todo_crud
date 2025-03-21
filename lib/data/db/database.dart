import 'package:f_crud_todo_consware/data/models/task.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';



class TaskDatabase {
  static Database? _db;

  static Future<Database> getDatabase() async {
    try {
      if (_db != null) return _db!;
      final path = '${await getDatabasesPath()}tasks.db';
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE tasks (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              isCompleted INTEGER NOT NULL
            )
          ''');
        },
      );
      return _db!;
    } catch (e) {
      debugPrint("Error opening database: $e");
      rethrow;
    }
  }

  static Future<List<Task>> getTasks() async {
    try {
      final db = await getDatabase();
      final List<Map<String, dynamic>> maps = await db.query('tasks');
      return maps.map((task) => Task.fromMap(task)).toList();
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
      return [];
    }
  }

  static Future<int> insertTask(Task task) async {
    try {
      final db = await getDatabase();
      return await db.insert('tasks', task.toMap());
    } catch (e) {
      debugPrint("Error inserting task: $e");
      return -1;
    }
  }

  static Future<int> updateTask(Task task) async {
    try {
      final db = await getDatabase();
      return await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    } catch (e) {
      debugPrint("Error updating task: $e");
      return -1;
    }
  }

  static Future<int> deleteTask(int id) async {
    try {
      final db = await getDatabase();
      return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint("Error deleting task: $e");
      return -1;
    }
  }
}