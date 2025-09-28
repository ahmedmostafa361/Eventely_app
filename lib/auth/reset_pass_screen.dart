import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utlis/app_colors .dart';
import '../utlis/app_text .dart';

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.darkBlueColor),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppTextStyle.normal20DarkBlue,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage(AppAssets.resetImage)),
            SizedBox(height: height * 0.02),
            CustomElevatedButton(
              onPressed: () {
                //reset password*****************
              },
              text: AppLocalizations.of(context)!.reset_password,
            ),
          ],
        ),
      ),
    );
  }
}
