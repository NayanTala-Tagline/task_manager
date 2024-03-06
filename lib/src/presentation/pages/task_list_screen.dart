import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/src/presentation/bloc/task_bloc.dart';
import 'package:task_manager/src/presentation/pages/add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.title});

  final String title;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    context.read<TaskBloc>().add(const FetchTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadedState) {
            return state.tasks!.isNotEmpty
                ? ListView.builder(
                    itemCount: state.tasks!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(
                            border: const Border(
                              left: BorderSide(
                                  width: 5.0, color: Color(0xff1E346F)),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffEDF3FF)),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              color: const Color(0xff1E346F),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: Text(
                                state.tasks![index].title[0].toString(),
                                style: const TextStyle(
                                    color: Color(0xff1E346F),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.tasks![index].title.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    state.tasks![index].description.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<TaskBloc>().add(
                                    DeleteTask(id: state.tasks![index].id));
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                radius: 12,
                                child: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                      "Please add a task by tapping on below + button",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1E346F),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1E346F),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
