import 'package:task_manager/src/domain/entites/task.dart';
import 'package:task_manager/src/domain/repositories/task_repository.dart';

class FetchTasksUseCase {
  TaskRepository taskRepository;
  FetchTasksUseCase(this.taskRepository);
  Future<List<TaskEntity>> execute() async {
    return await taskRepository.fetchTasks();
  }
}
