import 'package:flutter/material.dart';
import 'package:finishit/task.dart';

class CommonBox extends ChangeNotifier {
  List<Task> tasks = [
    // Task(name: "Buy Milk"),
    // Task(name: "Buy Eggs"),
    // Task(name: "Buy Bread"),
    // Task(name: "Buy Pudina"),
  ];

  int get taskCount {
    //this is a getter for tasks length
    return tasks.length;
  }

  void addTask(
    String newTaskTitle,
    String description,
    DateTime endDate,
  ) {
    final task = Task(
      name: newTaskTitle,
      description: description,
      endDate: endDate,
    );
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    notifyListeners();

    void reorderTasks(int oldIndex, int newIndex) {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final Task task = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, task);
      notifyListeners();
    }
  }

  void reorderTasks(int oldIndex, int newIndex) {}
}
