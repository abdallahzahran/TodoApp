import 'package:flutter/material.dart';
import 'package:todoapp/features/home/views/task_view.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomCardTask extends StatelessWidget {
  const CustomCardTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 15),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.89,
        height: MediaQuery.of(context).size.height * 0.16,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your today's tasks\n almost done!",
                    style: AppTextStyles.letStart(
                      fontsize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      text: '80',
                      style: AppTextStyles.letStart(
                        fontsize: 40,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '%',
                          style: AppTextStyles.letStart(
                            fontsize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      fixedSize: Size(130, 36), // Width: 150, Height: 50
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskView(),
                        ),
                      );
                    },
                    child: Text(
                      'View Tasks',
                      style: AppTextStyles.letStart(
                        fontsize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
