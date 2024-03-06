import 'package:task_manager/src/domain/entites/task.dart';

class TaskModel extends TaskEntity {
  TaskModel({super.id, required super.title, required super.description});
}
