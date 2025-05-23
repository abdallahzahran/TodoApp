import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/features/auth/views/login_screen.dart';
import 'package:todoapp/features/splach/let_start_screen.dart';
import '../../core/cache/cache_data.dart';
import '../../core/cache/cache_helper.dart';
import '../../core/cache/cache_keys.dart';
import '../../core/helper/my_navigator.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigate(context);
    super.initState();
  }
  void navigate(context)
  {
    Future.delayed(
        Duration(
            seconds: 2
        ),
            ()
        {
          // navigate to lets start view
          CacheData.firstTime = CacheHelper.getData(key: CacheKeys.firstTime);
          if(CacheData.firstTime != null)
          {
            // goto login
            MyNavigator.goTo(screen: ()=> LoginScreen(), isReplace: true);
          }
          else// first time
              {
            MyNavigator.goTo(screen: ()=> LetStartScreen(), isReplace: true);
          }

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            // logo as svg
            SvgPicture.asset(
               AppAssets.splach,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            SizedBox(height: 44,), // TODO: check MediaQuery

            // Text as app name
            Text(
              'todo',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary
              ),
            )


          ],
        ),
      ),
    );
  }
}