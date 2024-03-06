import 'package:task_manager/src/domain/entites/task.dart';
import 'package:task_manager/src/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository taskRepository;
  AddTaskUseCase(this.taskRepository);
  Future<bool> execute(TaskEntity task) async {
    return await taskRepository.addTask(task);
  }
}
