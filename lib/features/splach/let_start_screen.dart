
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/core/widgets/custom_elevated_button.dart';
import 'package:todoapp/features/auth/views/register_screen.dart';

import '../../core/cache/cache_helper.dart';
import '../../core/cache/cache_keys.dart';
import '../../core/helper/my_navigator.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';

class LetStartScreen extends StatelessWidget {
  const LetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Padding(
          padding:  EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.045,
              right: 22,
              left: 22
          ),

          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              [
                // svg image
                SvgPicture.asset(
                  AppAssets.letStart,
                  width: MediaQuery.of(context).size.width*0.8,
                ),

                // welcome text
                Text('welcome To \n Do It',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black
                  ),),

                // text
                Text('',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey
                  ),),

                // get started button
                CustomElevatedButton(textButton: 'lets start', onPressed: ()async
                {
                  await CacheHelper.saveData(key: CacheKeys.firstTime, value: false);
                  MyNavigator.goTo(screen: ()=> RegisterView());
                },)
              ],
            ),
          ),
        ),
      ),

    );
  }
}
