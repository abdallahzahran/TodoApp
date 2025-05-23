import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/core/helper/my_navigator.dart';
import 'package:todoapp/core/utils/app_assets.dart';
import 'package:todoapp/core/utils/app_colors.dart';
import 'package:todoapp/core/widgets/custom_elevated_button.dart';
import 'package:todoapp/core/widgets/custom_text__form_field.dart';
import 'package:todoapp/features/home/views/home_screen.dart';
import 'package:todoapp/features/auth/views/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/translation/translation_keys.dart';
import '../../home/manager/cubit/user_cubit/user_cubit.dart';
import '../manager/login_cubit/login_cubit.dart';
import '../manager/login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Success')));
                     UserCubit.get(context).getUserData(user: state.userModel) ;
                     MyNavigator.goTo(screen: HomeScreen());
                  } else if (state is LoginErrorState) {
                    Get.snackbar(
                      "Error",
                      state.error,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: LoginCubit.get(context).formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.flag,
                          height: MediaQuery.of(context).size.height * 0.36,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomTextFormField(
                          label: TranslationKeys.userName.tr,
                          prefixIconPath: AppAssets.profile,
                          controller: LoginCubit.get(context).emailController,
                          validator: (String? value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Password',
                          prefixIconPath: AppAssets.password,
                          suffixIconPath: AppAssets.lock,
                          obscureText: true,
                          controller:
                              LoginCubit.get(context).passwordController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        state is LoginLoadingState ?
                        Center(child: CircularProgressIndicator(),)
                            :
                        CustomElevatedButton(onPressed: LoginCubit.get(context).onLoginPressed,
                          textButton: TranslationKeys.login,
                        ),



                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        RichText(
                          text: TextSpan(
                            text: "Don't Have An Account?  ",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => RegisterView(),
                                          ),
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
