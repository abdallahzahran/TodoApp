import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';

Widget? customFloatingButton({
  required VoidCallback onPress,
  required String pathIcon,
  required String toolTip,
}) {
  return FloatingActionButton(
   // autofocus: true,
    tooltip: toolTip,
    shape: const CircleBorder(),
    backgroundColor: AppColors.primary,
    onPressed: onPress,
    child: SvgPicture.asset( pathIcon, width: 24, height: 24),
  );
}
