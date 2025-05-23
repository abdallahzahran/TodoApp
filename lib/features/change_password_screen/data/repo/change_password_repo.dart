import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todoapp/core/network/api_helper.dart';
import 'package:todoapp/core/network/api_keys.dart';
import 'package:todoapp/core/network/end_points.dart';
import 'package:todoapp/features/profile/repo/update_user_repo.dart';


class ChangePasswordRepo {
  //singleton
  ChangePasswordRepo._internal();
  static final ChangePasswordRepo _instance = ChangePasswordRepo._internal();
  factory ChangePasswordRepo() => _instance;
  ApiHelper apiHelper = ApiHelper(); // class that carry the dio instance
  // change password method
  Future<Either<String, String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,

  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.changePassword,
        isProtected: true,
        data: {
          ApiKeys.currentPasswordKey: currentPassword,
          ApiKeys.newPasswordKey: newPassword,
          ApiKeys.newPasswordConfirmKey: confirmPassword,
        },
      );
      DefaultResponseModel responseModel = DefaultResponseModel.fromJson(
        response.data,
      );

      if (responseModel.status != null && responseModel.status == true) {
        return Right(responseModel.message ?? "Password changed successfully");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response?.data['message'] != null) {
          return Left(e.response?.data['message']);
        }
      }

      // ignore: avoid_print
      print("Error ${e.toString()}");
      return Left(e.toString());
    }
  }

}