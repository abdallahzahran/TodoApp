import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/add_task_screen/data/repo/tasks_repo.dart';
import 'package:todoapp/features/add_task_screen/manager/edit_task_cubit/edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitialState());

  static EditTaskCubit get(context) => BlocProvider.of(context);

  static late TextEditingController InitialTitleController;
  static late TextEditingController InitialDescriptionController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(
    text: InitialTitleController.text,
  );
  TextEditingController descriptionController = TextEditingController(
    text: InitialDescriptionController.text,
  );
  TasksRepo tasksRepo = TasksRepo();
  static late int id;

  onUpDateBtnPressed(int? taskId) async {
    if (!formKey.currentState!.validate()) return;
    emit(EditTaskLoadingState());

    var result = await tasksRepo.updateTask(
      title: titleController.text,
      description: descriptionController.text,
      taskId: taskId!,
    );
    result.fold(
      (error) {
        emit(EditTaskErrorState(error: error));
      },
      (message) {
        emit(EditTaskSuccessState(message: message));
      },
    );
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}