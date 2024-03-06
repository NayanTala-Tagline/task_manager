import 'dart:math';

import 'package:task_manager/src/data/datasources/local/local_data_source.dart';
import 'package:task_manager/src/data/models/task_model.dart';
import 'package:task_manager/src/domain/entites/task.dart';
import 'package:task_manager/src/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  LocalDataSource localDataSource;
  TaskRepositoryImpl(this.localDataSource);
  @override
  Future<bool> addTask(TaskEntity task) async {
    return await localDataSource.addTask(TaskModel(
        id: task.id ?? Random().nextInt(10000),
        title: task.title,
        description: task.description));
  }

  @override
  Future<bool> deleteTask(int id) async {
    return await localDataSource.deleteTask(id);
  }

  @override
  Future<List<TaskEntity>> fetchTasks() async {
    return await localDataSource.fetchTasks();
  }
}
