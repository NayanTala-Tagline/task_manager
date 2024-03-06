import 'package:task_manager/src/domain/entites/task.dart';

abstract class TaskRepository {
  Future<bool> addTask(TaskEntity task);
  Future<List<TaskEntity>> fetchTasks();
  Future<bool> deleteTask(int id);
}
