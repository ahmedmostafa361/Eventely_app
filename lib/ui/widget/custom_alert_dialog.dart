import 'package:flutter/material.dart';

import '../../utlis/app_colors .dart';
import '../../utlis/app_routes .dart';
import '../../utlis/app_text .dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? middleText;
  final String? buttonText;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.middleText,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      title: Text(
        title ?? 'Welcome!',
        style: AppTextStyle.bold20DarkBlue,
        textAlign: TextAlign.center,
      ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              child: Text(
                middleText ?? 'Account sign-in successfully',
                style: AppTextStyle.bold16DarkBlue,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.homeScreenRoute);
              },
              child: Text(
                buttonText ?? 'Close',
                style: AppTextStyle.bold16White,
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
