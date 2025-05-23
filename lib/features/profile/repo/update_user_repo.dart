import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/core/network/api_helper.dart';
import 'package:todoapp/core/network/api_keys.dart';
import 'package:todoapp/core/network/api_response.dart';
import 'package:todoapp/core/network/end_points.dart';

class DefaultResponseModel {
  bool? status;
  String? message;

  DefaultResponseModel({this.status, this.message});

  DefaultResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class UpdateUserProfileRepo {
  //singleton instance
  UpdateUserProfileRepo._internal();
  static final UpdateUserProfileRepo _instance = UpdateUserProfileRepo._internal();
  factory UpdateUserProfileRepo() => _instance;
  ApiHelper apiHelper = ApiHelper();

  //methods
  Future<Either<String, String>> updateUserProfile({
    required String userName,
    required XFile? image,
  }) async {
    try {
      ApiResponse response = await apiHelper.putRequest(
        data: {
          ApiKeys.userNameApiKey: userName,
          ApiKeys.imageApiKey:
              image == null
                  ? null
                  : await MultipartFile.fromFile(
                      image.path,
                      filename: image.name,
                    ),
        },
        endPoint: EndPoints.updateUserProfile,
        isProtected: true,
      );

      if (response.status) {
        return Right(response.message);
      } else {
        throw Exception("update user profile Failed\nTry Again later");
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response?.data['message'] != null) {
          return Left(e.response?.data['message']);
        }
      }

      print("Error ${e.toString()}");
      return Left(e.toString());
    }
  }
}
