import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/core/network/api_helper.dart';
import 'package:todoapp/features/home/manager/cubit/user_cubit/user_cubit.dart';
import 'package:todoapp/features/profile/manager/update_profile_cubit/update_profile_state.dart';
import 'package:todoapp/features/profile/repo/update_user_repo.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  ApiHelper apiHelper = ApiHelper();
  UpdateUserProfileRepo updateProfileRepo = UpdateUserProfileRepo();
  
  // تحسين طريقة الوصول إلى الـ cubit
  static UpdateProfileCubit? _instance;
  static UpdateProfileCubit get instance {
    _instance ??= UpdateProfileCubit();
    return _instance!;
  }
  
  // طريقة للحصول على الـ cubit من الـ context
  static UpdateProfileCubit of(BuildContext context) {
    try {
      return BlocProvider.of<UpdateProfileCubit>(context);
    } catch (e) {
      return instance;
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  XFile? image;
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
    // تعيين اسم المستخدم الحالي في حقل الإدخال
    if (UserCubit.get(context).userModel != null) {
      userNameController.text = UserCubit.get(context).userModel!.username ?? '';
    }
  }

  void updateProfileBtn() async {
    if (formKey.currentState!.validate() && _context != null) {
      emit(UpdateProfileLoadingState());
      var result = await updateProfileRepo.updateUserProfile(
        userName: userNameController.text,
        image: image,
      );
      result.fold(
        (String error) {
          emit(UpdateProfileErrorState(error: error));
        },
        (r) {
          final userCubit = UserCubit.get(_context!);
          // تحديث البيانات في UserCubit
          userCubit.updateUserData(
            username: userNameController.text,
            imagePath: image != null ? r : null,
          );
          emit(UpdateProfileSuccessState());
        },
      );
    }
  }

  @override
  Future<void> close() {
    _instance = null;
    return super.close();
  }
}
