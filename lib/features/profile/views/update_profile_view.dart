import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/core/helper/my_navigator.dart';
import 'package:todoapp/core/widgets/custom_circular_progress_indicator.dart';
import 'package:todoapp/core/widgets/custom_elevated_button.dart';
import 'package:todoapp/core/widgets/custom_text__form_field.dart';
import 'package:todoapp/core/widgets/image_manager/image_manager_view.dart';
import 'package:todoapp/features/home/manager/cubit/user_cubit/user_cubit.dart';
import 'package:todoapp/features/home/views/home_screen.dart';
import 'package:todoapp/features/profile/manager/update_profile_cubit/update_profile_cubit.dart';
import 'package:todoapp/features/profile/manager/update_profile_cubit/update_profile_state.dart';

import '../../../core/translation/translation_keys.dart';
import '../../../core/utils/app_assets.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final UpdateProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = UpdateProfileCubit.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.setContext(context);
    });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("User information updated successfully"),
              ),
            );
            MyNavigator.goTo(
              screen: HomeScreen(),
              isReplace: true,
            );
          } else if (state is UpdateProfileErrorState) {
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
          final userCubit = UserCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Form(
              key: _cubit.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ImageManagerView(
                      onPicked: (XFile image) {
                        _cubit.image = image;
                      },
                      pickedBody: (XFile image) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.36,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: FileImage(image as dynamic),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      unPickedBody: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.network(
                          userCubit.userModel?.imagePath ?? AppAssets.flag,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.36,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppAssets.flag,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.36,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 23),
                    CustomTextFormField(
                      label: TranslationKeys.userNameTitle.tr,
                      controller: _cubit.userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 23),
                    state is UpdateProfileLoadingState
                        ? const CustomCircularProgressIndicator()
                        : CustomElevatedButton(
                            onPressed: _cubit.updateProfileBtn,
                            textButton: TranslationKeys.updateProfileTitle.tr,
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
