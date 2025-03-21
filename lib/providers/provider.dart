import 'package:flutter/material.dart';
import '../data/models/task.dart';
import '../data/db/database.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await TaskDatabase.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final newTask = Task(title: title);
    await TaskDatabase.insertTask(newTask);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await TaskDatabase.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabase.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleCompleted(Task task) async {
    task.isCompleted = !task.isCompleted;
    await updateTask(task);
  }
}
