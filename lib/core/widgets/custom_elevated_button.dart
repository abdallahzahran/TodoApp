import 'package:flutter/material.dart';
import 'package:todoapp/core/utils/app_text_styles.dart';
import '../utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    Key? key,
    required this.textButton,
    required this.onPressed,
    this.color = AppColors.primary,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          //padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          elevation: 5,
          shadowColor: AppColors.primary.withAlpha(200),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(
          textAlign: TextAlign.center,
          textButton,
          style: AppTextStyles.letStart(color: AppColors.white,fontsize: 19,fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
