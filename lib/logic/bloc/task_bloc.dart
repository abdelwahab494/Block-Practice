import 'package:bloc_cubit_practice/data/models/task_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      emit(
        TaskUpdates([
          ...state.tasksList,
          TaskModel(id: Uuid().v4(), title: event.title, isCompleted: false),
        ]),
      );
      // emit(TaskUpdates(List.from(state.tasksList)..add(task)));
    });

    on<RemoveTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.tasksList
          .where((task) => task.id != event.id)
          .toList();
      emit(TaskUpdates(newList));
    });

    on<ToggleTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.tasksList.map((task) {
        return task.id == event.id
            ? task.copyWith(isCompleted: !task.isCompleted)
            : task;
      }).toList();
      emit(TaskUpdates(newList));
    });
  }
}
