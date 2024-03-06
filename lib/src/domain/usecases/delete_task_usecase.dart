import 'package:task_manager/src/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  TaskRepository taskRepository;
  DeleteTaskUseCase(this.taskRepository);
  Future<bool> execute(int taskId) async {
   return await taskRepository.deleteTask(taskId);
  }
}
