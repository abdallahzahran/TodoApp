import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/core/widgets/custom_elevated_button.dart';
import 'package:todoapp/core/widgets/custom_text__form_field.dart';
import 'package:todoapp/features/auth/views/login_screen.dart';
import '../../../core/helper/my_navigator.dart';
import '../../../core/translation/translation_keys.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/image_manager/image_manager_view.dart';
import '../manager/register_cubit/register_cubit.dart';
import '../manager/register_cubit/register_state.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // form
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterErrorState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    } else if (state is RegisterSuccessState) {
                      MyNavigator.goTo(
                        screen: () => LoginScreen(),
                        isReplace: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: RegisterCubit.get(context).formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ImageManagerView(
                              onPicked: (XFile image) {
                                RegisterCubit.get(context).image = image;
                              },
                              pickedBody: (XFile image) {
                                return Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: FileImage(File(image.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              unPickedBody: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  AppAssets.flag,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.36,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextFormField(
                              label: TranslationKeys.userName.tr,
                              prefixIconPath: AppAssets.profile,
                              controller:
                                  RegisterCubit.get(context).emailController,
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
                                  RegisterCubit.get(context).passwordController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            CustomTextFormField(
                              label: 'Confirm Password',
                              prefixIconPath: AppAssets.password,
                              suffixIconPath: AppAssets.lock,
                              obscureText: true,
                              controller:
                                  RegisterCubit.get(
                                    context,
                                  ).passwordConfirmController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            state is RegisterLoadingState
                                ? Center(child: CircularProgressIndicator())
                                : CustomElevatedButton(
                                  onPressed:
                                      RegisterCubit.get(
                                        context,
                                      ).onRegisterPressed,
                                  textButton: TranslationKeys.register,
                                ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),

                            RichText(
                              text: TextSpan(
                                text: 'Already Have An Account? ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Login',
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
                                                    (context) => LoginScreen(),
                                              ),
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
