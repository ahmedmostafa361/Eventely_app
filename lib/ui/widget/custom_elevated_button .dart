import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final bool hasIcon;
  final Widget? customInButton;

  CustomElevatedButton({
    super.key,
    this.customInButton,
    this.hasIcon = false,
    required this.onPressed,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderSideColor,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: height * 0.018),
        backgroundColor: backgroundColor ?? AppColors.darkBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
          side: BorderSide(
            color: borderSideColor ?? AppColors.transparentColor,
            width: 1,
          ),
        ),
        elevation: 0,
      ),
      child: hasIcon
          ? customInButton
          : Text(text!, style: textStyle ?? AppTextStyle.normal20White),
    );
  }
}
