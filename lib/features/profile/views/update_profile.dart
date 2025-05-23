import 'package:flutter/material.dart';
import 'package:todoapp/core/utils/app_assets.dart';
import 'package:todoapp/core/widgets/custom_elevated_button.dart';
import 'package:todoapp/core/widgets/custom_text__form_field.dart';
import 'package:todoapp/features/profile/views/profile_screen.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AppAssets.flag,
              height: MediaQuery.of(context).size.height * 0.36,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            CustomTextFormField(
              label: 'Username',
              prefixIconPath: AppAssets.profile,
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            CustomElevatedButton(textButton: 'Update', onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );}),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Don’t Have An Account?  ",
            //       style: AppTextStyles.letStart(
            //         fontsize: 14,
            //         fontWeight: FontWeight.w200,
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => RegisterScreen()),
            //         );
            //       },
            //       child: Text(
            //         "Register",
            //         style: AppTextStyles.letStart(
            //           fontsize: 14,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
