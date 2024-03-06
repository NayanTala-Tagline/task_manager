import 'package:task_manager/src/data/models/task_model.dart';

abstract class LocalDataSource {
  Future<List<TaskModel>> fetchTasks();
  Future<bool> addTask(TaskModel task);
  Future<bool> deleteTask(int id);
}

class LocalDataSourceImpl extends LocalDataSource {
  List<TaskModel> taskList = [];
  @override
  Future<bool> addTask(TaskModel task) async {
    try {
      taskList.add(task);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteTask(int id) {
    try {
      taskList.removeWhere((element) => element.id == id);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<List<TaskModel>> fetchTasks() async {
    return Future.value(taskList);
  }
}
