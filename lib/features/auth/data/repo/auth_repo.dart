import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/features/home/data/models/user_model.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_keys.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';


class AuthRepo
{
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, void>> register({required String username, required String password, XFile? image})async
  {
    try
    {
      await apiHelper.postRequest(
          endPoint: EndPoints.register,
          data:
          {
            'username': username,
            'password': password,
            'image': image == null ? null :
            await MultipartFile.fromFile(image.path, filename: image.name),
          }
      );
      return Right(null);
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


  Future<Either<String, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.status) {
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(response.data);
        if (loginResponseModel.user != null) {
          // store tokens
          await CacheHelper.saveData(key: CacheKeys.accessToken, value: loginResponseModel.accessToken);
          await CacheHelper.saveData(key: CacheKeys.refreshToken, value: loginResponseModel.refreshToken);
          return Right(loginResponseModel.user!);
        }
      }
      return Left(response.message);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response?.data['message'] != null) {
          return Left(e.response?.data['message']);
        }
      }
      print("Login Error: ${e.toString()}");
      return Left(e.toString());
    }
  }



}