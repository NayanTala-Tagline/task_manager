import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:task_manager/src/data/datasources/local/local_data_source.dart';
import 'package:task_manager/src/data/models/task_model.dart';
import 'package:task_manager/src/data/repositories/task_repository_impl.dart';
import 'package:task_manager/src/domain/entites/task.dart';
import 'package:task_manager/src/domain/repositories/task_repository.dart';
import 'package:task_manager/src/domain/usecases/add_task_usecase.dart';
import 'package:task_manager/src/domain/usecases/delete_task_usecase.dart';
import 'package:task_manager/src/domain/usecases/fetch_task_usecase.dart';
import 'package:task_manager/src/presentation/bloc/task_bloc.dart';
import 'package:test/test.dart';

// Mock Bloc
class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

void main() {
  mainBloc();
}

void mainBloc() {
  TaskRepository repository = TaskRepositoryImpl(LocalDataSourceImpl());

  group('TaskBloc', () {
    blocTest<TaskBloc, TaskState>(
      'emits [] when nothing is added',
      build: () => TaskBloc(
        AddTaskUseCase(repository),
        DeleteTaskUseCase(repository),
        FetchTasksUseCase(repository),
      ),
      expect: () => [],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading(), const TaskLoadedState([])] when task are fetched',
      build: () => TaskBloc(
        AddTaskUseCase(repository),
        DeleteTaskUseCase(repository),
        FetchTasksUseCase(repository),
      ),
      act: (bloc) => bloc.add(const FetchTaskEvent()),
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<TaskLoading>(),
        isA<TaskLoadedState>()
            .having((state) => state.tasks, "state after data fatched", [])
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [const TaskLoadedState()] when task are added',
      build: () => TaskBloc(
        AddTaskUseCase(repository),
        DeleteTaskUseCase(repository),
        FetchTasksUseCase(repository),
      ),
      act: (bloc) => bloc.add(const AddTaskEvent(
          taskEntity:
              TaskEntity(id: 1, title: "title", description: "description"))),
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<TaskLoadedState>().having(
            (state) => state.tasks,
            "state after data added",
            [TaskModel(id: 1, title: "title", description: "description")])
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [const TaskLoadedState()] when task is deleted',
      build: () => TaskBloc(
        AddTaskUseCase(repository),
        DeleteTaskUseCase(repository),
        FetchTasksUseCase(repository),
      ),
      act: (bloc) => bloc.add(const DeleteTask(id: 1)),
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<TaskLoadedState>()
            .having((state) => state.tasks, "state after data deleted", [])
      ],
    );
  });
}
