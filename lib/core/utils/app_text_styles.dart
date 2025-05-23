import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle letStart({
    Color color = AppColors.black,
    double fontsize = 24,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontsize,
      fontFamily: 'Lexend Deca',
      fontWeight: fontWeight,

    );
  }
}
