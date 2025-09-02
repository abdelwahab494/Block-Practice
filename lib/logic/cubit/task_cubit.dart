import 'package:bloc_cubit_practice/data/models/task_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void addTask({required String title}) {
    emit(TaskUpdates([...state.tasksList, TaskModel(id: Uuid().v4(), title: title, isCompleted: false)]));
    // emit(TaskUpdates(List.from(state.tasksList)..add(task)));
  }

  void removeTask(String id) {
    final List<TaskModel> newList = state.tasksList
        .where((task) => task.id != id)
        .toList();
    emit(TaskUpdates(newList));
  }

  void toggleTask(String id) {
    final List<TaskModel> newList = state.tasksList.map((task) {
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(TaskUpdates(newList));
  }
}
