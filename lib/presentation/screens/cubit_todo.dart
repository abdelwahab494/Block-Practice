import 'package:bloc_cubit_practice/data/models/task_model.dart';
import 'package:bloc_cubit_practice/logic/cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitTodo extends StatelessWidget {
  CubitTodo({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cubit todo".toUpperCase(),
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
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            final TaskCubit taskCubit = context.read<TaskCubit>();
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
                                taskCubit.toggleTask(task.id);
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
                                taskCubit.removeTask(task.id);
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
                        context.read<TaskCubit>().addTask(
                          title: controller.text,
                        );
                        print(context.read<TaskCubit>().state.tasksList);
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
