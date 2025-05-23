import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todoapp/core/helper/my_navigator.dart';
import 'package:todoapp/core/widgets/custom_circular_progress_indicator.dart';
import 'package:todoapp/core/widgets/custom_elevated_button.dart';
import 'package:todoapp/core/widgets/custom_text__form_field.dart';
import 'package:todoapp/features/change_password_screen/manager/change_password_cubit/change_password_cubit.dart';
import 'package:todoapp/features/change_password_screen/manager/change_password_cubit/change_password_state.dart';
import 'package:todoapp/features/profile/views/profile_screen.dart';
import '../../../core/translation/translation_keys.dart';
import '../../../core/utils/app_assets.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordLoadingState) {
            return; // Prevent multiple taps while loading
          } else if (state is ChangePasswordSuccessState) {
            //UserCubit.get(context).getUserDataFromAPI();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("User information updated successfully")),
            );
            MyNavigator.goTo(screen: ProfileScreen(), isReplace: true);
          } else if (state is ChangePasswordErrorState) {
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
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Form(
              key: ChangePasswordCubit.get(context).formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 375,
                      width: double.infinity,
                      child: Image.asset(
                        AppAssets.flag,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 23),
                    CustomTextFormField(
                    //  prefixIconPath: AppAssets.password,
                      label: TranslationKeys.oldPasswordTitle.tr,
                      controller: ChangePasswordCubit.get(context).currentPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "old password cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 23),
                    CustomTextFormField(
                      label: TranslationKeys.newPasswordTitle.tr,
                      controller: ChangePasswordCubit.get(context).passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 23),
                    CustomTextFormField(
                      label: TranslationKeys.confirmPassWordTitle.tr,
                      controller: ChangePasswordCubit.get(context).confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty || value != ChangePasswordCubit.get(context).passwordController.text) {
                          return "Password cannot be empty and must match the new password";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 23),
                    state is ChangePasswordLoadingState
                        ? CustomCircularProgressIndicator()
                        : CustomElevatedButton(
                            onPressed: ChangePasswordCubit.get(context).changePassword,
                            textButton: TranslationKeys.saveBtnTitle.tr,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
