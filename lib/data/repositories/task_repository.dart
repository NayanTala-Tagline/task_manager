import 'package:task_manager/domain/entities.dart';

abstract class TaskRepository {
  Future<void> createTask(String title);
  Future<List<Task>> fetchTasks();
  Future<void> deleteTask(int taskId);
}
