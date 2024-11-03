import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];

  DateTime selectedDate = DateTime.now();

  Future<void> getTasks() async {
    List<TaskModel> allTasks =
        await FirebaseFunctions.getAllTasksFromFirestore();
    tasks = allTasks
        .where(
          (task) =>
              task.date.year == selectedDate.year &&
              task.date.month == selectedDate.month &&
              task.date.day == selectedDate.day,
        )
        .toList();
    notifyListeners();
  }

  void getSelectedDateTasks(DateTime selectedDate) {
    this.selectedDate = selectedDate;
    getTasks();
  }
}
