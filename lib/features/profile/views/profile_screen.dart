import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/widgets/custom_card_profile.dart';
import 'package:todoapp/features/change_password_screen/view/change_password_view.dart';
import 'package:todoapp/features/profile/views/setting_view.dart';
import 'package:todoapp/features/profile/views/update_profile_view.dart';
import 'package:todoapp/features/splach/splach_screen.dart';
import '../../../core/helper/my_responsive.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../home/manager/cubit/user_cubit/user_cubit.dart';
import '../../home/manager/cubit/user_cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<String> iconsList = [
    AppAssets.profile,
    AppAssets.lock,
    AppAssets.setting,
  ];

  final List<String> titleList = [
    'Update Profile',
    'Change Password',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsetsDirectional.only(end: 16),
                        height: MyResponsive.height(context, value: 60),
                        width: MyResponsive.height(context, value: 60),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: state is UserGetSuccess &&
                                    state.userModel.imagePath != null &&
                                    state.userModel.imagePath!.isNotEmpty
                                ? NetworkImage(state.userModel.imagePath!)
                                : AssetImage(AppAssets.flag),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SplashView()),
                        );
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!',
                          style: AppTextStyles.letStart(
                            fontsize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        if (state is UserGetSuccess)
                          Text(
                            state.userModel.username ?? 'No Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: AppColors.black,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                InkWell(
                  child: CustomCardProfile(
                    iconPath: AppAssets.profile,
                    text: 'Update Profile',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: UserCubit.get(context),
                          child: UpdateProfileScreen(),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  child: CustomCardProfile(
                    iconPath: AppAssets.lock,
                    text: 'Change Password',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: UserCubit.get(context),
                          child: const ChangePasswordScreen(),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  child: CustomCardProfile(
                    iconPath: AppAssets.setting,
                    text: 'Settings',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsView()),
                    );
                  },
                ),

                // ListView.separated(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: 3,
                //   itemBuilder: (context, index) {
                //     return CustomCardProfile(iconPath: iconsList[index],  text: titleList[index],);
                //   },
                //     separatorBuilder: (context, index) => SizedBox(height: 12),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
