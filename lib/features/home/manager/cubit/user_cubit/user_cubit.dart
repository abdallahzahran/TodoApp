import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/home/manager/cubit/user_cubit/user_state.dart';

import '../../../data/models/user_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  static String sharedImageOnAllScreens = '';
  UserModel? userModel;

  void getUserData({required UserModel user}) {
    userModel = user;
    if (user.imagePath != null) {
      sharedImageOnAllScreens = user.imagePath!;
    }
    emit(UserGetSuccess(userModel: user));
  }

  void updateUserData({String? username, String? imagePath}) {
    if (userModel != null) {
      if (username != null) {
        userModel!.username = username;
      }
      if (imagePath != null) {
        userModel!.imagePath = imagePath;
        sharedImageOnAllScreens = imagePath;
      }
      emit(UserGetSuccess(userModel: userModel!));
    }
  }

  /// تحديث الحالة فقط من البيانات الموجودة مسبقًا
  void getUserDataFromAPI() {
    if (userModel != null) {
      emit(UserGetSuccess(userModel: userModel!));
    }
  }
}
