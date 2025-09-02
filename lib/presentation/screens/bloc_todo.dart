import 'package:bloc_cubit_practice/data/models/task_model.dart';
import 'package:bloc_cubit_practice/logic/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocTodo extends StatelessWidget {
  const BlocTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bloc todo".toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final TaskBloc taskBloc = context.read<TaskBloc>();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                spacing: 15,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.tasksList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final TaskModel task = state.tasksList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              activeColor: Colors.white,
                              value: task.isCompleted,
                              onChanged: (value) {
                                taskBloc.add(ToggleTaskEvent(id: task.id));
                              },
                            ),
                            Text(
                              task.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                taskBloc.add(RemoveTaskEvent(id: task.id));
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add New Task"),
                  content: TextField(
                    autofocus: true,
                    style: TextStyle(color: Colors.white),
                    controller: controller,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      hintText: "Enter a Task",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.text.isEmpty) return;
                        context.read<TaskBloc>().add(
                          AddTaskEvent(title: controller.text),
                        );
                        controller.clear();
                        Navigator.pop(context);
                      },
                      child: Text("ADD", style: TextStyle(color: Colors.black)),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.playlist_add, color: Colors.black, size: 30),
        ),
      ),
    );
  }
}
