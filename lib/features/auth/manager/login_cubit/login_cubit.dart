import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  String? error;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final AuthRepo authRepo = AuthRepo(); // ربط بالمستودع

  Future<void> onLoginPressed() async {
    error = null;

    if (!formKey.currentState!.validate()) {
      error = 'Please complete the form correctly.';
      emit(LoginErrorState(error!));
      return;
    }

    emit(LoginLoadingState());

    final result = await authRepo.login(
      username: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    result.fold(
      (failure) {
        emit(LoginErrorState(failure));
      },
      (userModel) {
        emit(LoginSuccessState(userModel));
      },
    );
  }
}