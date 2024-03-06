part of 'task_bloc.dart';

@immutable
sealed class TaskState {
  final List<TaskEntity>? tasks;

  const TaskState({this.tasks});
}

final class TaskLoading extends TaskState {}

final class TaskLoadedState extends TaskState {
  const TaskLoadedState(List<TaskEntity> tasks) : super(tasks: tasks);
}

final class TaskErrorState extends TaskState {
  const TaskErrorState(List<TaskEntity> tasks) : super(tasks: tasks);
}
