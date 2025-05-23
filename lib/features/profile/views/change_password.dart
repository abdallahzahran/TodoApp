// import 'package:flutter/material.dart';
// import 'package:todoapp/core/utils/app_assets.dart';
// import 'package:todoapp/core/widgets/custom_elevated_button.dart';
// import 'package:todoapp/core/widgets/custom_text__form_field.dart';
// import 'package:todoapp/features/profile/views/profile_screen.dart';

// class ChangePasswordView extends StatelessWidget {
//   const ChangePasswordView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.asset(
//               AppAssets.flag,
//               height: MediaQuery.of(context).size.height * 0.36,
//               width: double.infinity,
//               fit: BoxFit.fill,

//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             CustomTextFormField(
//               label: 'Old Password',
//               prefixIconPath: AppAssets.profile,
//             ),

//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             CustomTextFormField(
//               label: 'New Password',
//               prefixIconPath: AppAssets.profile,
//             ),

//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             CustomTextFormField(
//               label: 'Confirm Password',
//               prefixIconPath: AppAssets.profile,
//             ),

//             SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//             CustomElevatedButton(textButton: 'Save', onPressed: () { Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ProfileScreen()),
//             );}),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//           ],
//         ),
//       ),
//     );
//   }
// }
