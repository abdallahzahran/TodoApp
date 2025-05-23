import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todoapp/core/utils/app_colors.dart';
import 'core/cache/cache_data.dart';
import 'core/cache/cache_helper.dart';
import 'core/translation/translation_helper.dart';
import 'features/home/manager/cubit/user_cubit/user_cubit.dart';
import 'features/splach/splach_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await TranslationHelper.setLanguage();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (context)=> UserCubit(),
      child: GetMaterialApp(
        locale: Locale(CacheData.lang!),
        translations: TranslationHelper(),
        theme: ThemeData(
          fontFamily: 'Lexend Deca',
          colorSchemeSeed: AppColors.primary,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}