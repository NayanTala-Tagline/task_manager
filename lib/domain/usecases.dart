// Use cases
import 'package:task_manager/domain/entities.dart';

abstract class CreateTaskUseCase {
  Future<void> createTask(String title);
}

abstract class FetchTasksUseCase {
  Future<List<Task>> fetchTasks();
}

abstract class DeleteTaskUseCase {
  Future<void> deleteTask(int taskId);
}
