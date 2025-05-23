import 'package:flutter/material.dart';

import '../cache/cache_keys.dart';

abstract class TranslationKeys
{
  static const Locale localeEN = Locale(CacheKeys.keyEN);
  static const Locale localeAR = Locale(CacheKeys.keyAR);
  static const welcomeToDoIt ="welcome To\nDo It !";
  static const readyToConquer ="Ready to conquer your tasks? Let's Do It together.";
  static const letStart ="Let's Start";
  static const register ="register";
  static const login ="login";
  static const hello ="hello";
  static const addTask ="addTask";
  static const addTaskTitle ="addTaskTitle";
  static const title ="title";
  static const description ="description";
  static const group ="group";
  static const endDate ="endDate";
  static const userName ="userName";
  static const userNameTitle ="userNameTitle";
  static const updateProfileTitle ="updateProfileTitle";
  static const oldPasswordTitle ="oldPasswordTitle";
  static const newPasswordTitle ="newPasswordTitle";
  static const confirmPassWordTitle ="confirmPassWordTitle";
  static const saveBtnTitle ="saveBtnTitle";
  static const deleteTaskTitle = "deleteTaskTitle";
  static const editTaskTitle = "editTaskTitle";

  static var taskGroupName;

  static var noTaskMsgTitle;
}