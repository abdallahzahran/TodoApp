import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/api_helper.dart';
import '../../../../../core/network/api_response.dart';
import '../../../../../core/network/end_points.dart';
import '../models/get_tasks_response_model.dart';

class TasksRepo
{
  // singletone
  TasksRepo._internal();
  static final TasksRepo _repo = TasksRepo._internal();
  factory TasksRepo() => _repo;

  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, String>> addTask({required TaskModel task})async
  {
    try
    {

      ApiResponse response = await apiHelper.postRequest(
          endPoint: EndPoints.addTask,
          isProtected: true,
          data: await task.toJson()
      );

      if(response.status && response.status == true)
      {
        return Right(response.message);
      }
      else
      {
        throw Exception("Something went wrong");
      }

    }
    catch(e)
    {
      if(e is DioException)
      {
        if(e.response != null && e.response?.data['message'] != null) {
          return Left(e.response?.data['message']);
        }
      }

      print("Error ${e.toString()}");
      return Left(e.toString());
    }

  }
}