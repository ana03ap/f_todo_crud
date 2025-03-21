import 'package:flutter/material.dart';
import '../data/models/task.dart';
import '../data/db/database.dart';


//Aqui se extiende de ChangeNotifier, o sea  que puede notificar a los widgets que están escuchando sobre cambios en los datoss.
class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];//lista de las tareas
  List<Task> get tasks => _tasks;// el getter


// espero a que se carguen las tareas y le aviso al resto 
  Future<void> loadTasks() async {
    _tasks = await TaskDatabase.getTasks();
    notifyListeners();
  }


//añade tareas
  Future<void> addTask(String title) async {
    final newTask = Task(title: title);
    await TaskDatabase.insertTask(newTask);
    await loadTasks();
  }


//updatea
  Future<void> updateTask(Task task) async {
    await TaskDatabase.updateTask(task);
    await loadTasks();
  }


//borra
  Future<void> deleteTask(int id) async {
    await TaskDatabase.deleteTask(id);
    await loadTasks();
  }


//pa poder checkear si está o no está hecha 
  Future<void> toggleCompleted(Task task) async {
    task.isCompleted = !task.isCompleted;
    await updateTask(task);
  }
}
