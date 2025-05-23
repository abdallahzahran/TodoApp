import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/core/utils/app_assets.dart';
import 'package:todoapp/core/utils/app_colors.dart';
import 'package:todoapp/core/utils/app_text_styles.dart';
import 'package:todoapp/core/widgets/custom_card.dart';
import 'package:todoapp/core/widgets/custom_text__form_field.dart';
import 'filter_panel.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        title: Text(
          'Tasks',
          style: AppTextStyles.letStart(
            fontsize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.primary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FilterPanel(),
              );
            },
          );
        },
        child: SvgPicture.asset(AppAssets.filter),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Search...',
              suffixIconPath: AppAssets.search,
              padding: 1,
            ),
            Row(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Results',
                  style: AppTextStyles.letStart(
                    fontsize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppColors.primary.withAlpha(50),
                  ),
                  child: Center(
                    child: Text(
                      '5',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.letStart(
                        fontsize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Expanded(
              child: ListView(
                children: [
                  CustomCard(
                    statusText: 'In Progress',
                    statusColor: AppColors.lightPrimary,
                    statusIcon: AppAssets.work,
                    statusTextColor: AppColors.primary,
                  ),
                  CustomCard(
                    statusText: 'Done',
                    statusColor: AppColors.primary,
                    statusIcon: AppAssets.work,
                    statusTextColor: AppColors.white,
                  ),
                  CustomCard(
                    statusText: 'Done',
                    statusColor: AppColors.primary,
                    statusIcon: AppAssets.home,
                    statusTextColor: AppColors.white,
                  ),
                  CustomCard(
                    statusText: 'Missed',
                    statusColor: AppColors.red,
                    statusIcon: AppAssets.personal,
                    statusTextColor: AppColors.white,
                  ),
                ],
                // builder: (context, index) => SizedBox(height: 12),
              ),
            ),

            //  CustomCard(),
          ],
        ),
      ),
    );
  }
}




