part of 'task_bloc.dart';


sealed class TaskEvent {
  final TaskEntity? taskEntity;
  final int? id;

  const TaskEvent({this.taskEntity, this.id});
}

class AddTaskEvent extends TaskEvent {
  const AddTaskEvent({required super.taskEntity});
}

class FetchTaskEvent extends TaskEvent {
  const FetchTaskEvent();
}

class DeleteTask extends TaskEvent {
  const DeleteTask({required super.id});
}
