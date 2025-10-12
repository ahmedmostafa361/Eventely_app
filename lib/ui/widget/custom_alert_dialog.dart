import 'package:flutter/material.dart';

import '../../utlis/app_colors .dart';
import '../../utlis/app_text .dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? middleText;
  final String? buttonText;
  final bool button;
  final Widget? contentCustomWidget;
  final Function? pushOrPopNavigator;
  final TextStyle? middleTextStyle;
  final TextStyle? titleTextStyle;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.middleText,
    this.buttonText,
    this.button = true,
    this.contentCustomWidget,
    this.pushOrPopNavigator,
    this.middleTextStyle,
    this.titleTextStyle
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
        style: titleTextStyle ?? AppTextStyle.bold20DarkBlue,
        textAlign: TextAlign.center,
      ),
      content: contentCustomWidget,
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
                style: middleTextStyle ?? AppTextStyle.bold16Green,
                textAlign: TextAlign.center,
              ),
            ),
            button ? ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                pushOrPopNavigator?.call();
              },
              child: Text(
                buttonText ?? 'Close',
                style: AppTextStyle.bold16White,
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlueColor,
              ),
            ) :
            SizedBox(),
          ],
        ),
      ],
    );
  }
}
