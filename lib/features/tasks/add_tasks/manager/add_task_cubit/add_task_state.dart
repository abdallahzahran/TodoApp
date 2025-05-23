abstract class AddTaskState{}

class AddTaskInitialState extends AddTaskState{}

class AddTaskChangeEndDateState extends AddTaskState{}

class AddTaskChangeGroupState extends AddTaskState{}

class AddTaskChangeImageState extends AddTaskState{}

class AddTaskLoadingState extends AddTaskState{}

class AddTaskSuccessState extends AddTaskState{
  String message;
  AddTaskSuccessState({required this.message});
}

class AddTaskErrorState extends AddTaskState
{
  String error;
  AddTaskErrorState({required this.error});
}