import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/core/utils/app_assets.dart';

class CustomCard extends StatelessWidget {
  final String statusText;
  final Color statusColor;
  final Color statusTextColor;
  final String statusIcon;

  const CustomCard({
    super.key,
    required this.statusText,
    required this.statusColor,
    required this.statusTextColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 320,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppAssets.flag,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Go to supermarket to buy\n some milk & eggs",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: statusTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        statusIcon,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Padding(
//   padding: const EdgeInsetsDirectional.only(bottom: 15),
//   child: Container(
//     width: MediaQuery.of(context).size.height * 0.41,
//     height: MediaQuery.of(context).size.height * 0.13,
//     decoration: BoxDecoration(
//       color: AppColors.primary.withAlpha(50),
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'My First Tasks',
//                 style: AppTextStyles.letStart(
//                   fontsize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.grey,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 '11/03/2025 \n 05:00 PM',
//                 style: AppTextStyles.letStart(
//                   fontsize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.grey,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             'Improve my English skills\n by trying to speek',
//             style: AppTextStyles.letStart(
//               fontsize: 14,
//               fontWeight: FontWeight.w300,
//               color: AppColors.black,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// );