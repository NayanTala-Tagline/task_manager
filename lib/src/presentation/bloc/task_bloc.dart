import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/src/domain/entites/task.dart';
import 'package:task_manager/src/domain/usecases/add_task_usecase.dart';
import 'package:task_manager/src/domain/usecases/delete_task_usecase.dart';
import 'package:task_manager/src/domain/usecases/fetch_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase _addTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final FetchTasksUseCase _fetchTasksUseCase;

  TaskBloc(
      this._addTaskUseCase, this._deleteTaskUseCase, this._fetchTasksUseCase)
      : super(TaskLoading()) {
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<FetchTaskEvent>(_onFetchTasks);
  }

  FutureOr<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    await _addTaskUseCase.execute(event.taskEntity!);
    final tasks = await _fetchTasksUseCase.execute();
    emit(TaskLoadedState(tasks));
  }

  FutureOr<void> _onDeleteTask(
      DeleteTask event, Emitter<TaskState> emit) async {
    _deleteTaskUseCase.execute(event.id!);
    final tasks = await _fetchTasksUseCase.execute();
    emit(TaskLoadedState(tasks));
  }

  FutureOr<void> _onFetchTasks(
      FetchTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final tasks = await _fetchTasksUseCase.execute();
    emit(TaskLoadedState(tasks));
  }
}
