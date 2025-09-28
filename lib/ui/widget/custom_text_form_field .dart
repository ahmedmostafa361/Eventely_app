import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

import '../../utlis/app_colors .dart';

class CustomTextFormField extends StatelessWidget {
  final Color BorderSideColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  CustomTextFormField({
    super.key,
    this.BorderSideColor = AppColors.greyColor,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.hintStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: outlineInputBorder(BorderSideColor: BorderSideColor),
        enabledBorder: outlineInputBorder(BorderSideColor: BorderSideColor),
        focusedBorder: outlineInputBorder(BorderSideColor: BorderSideColor),
        errorBorder: outlineInputBorder(BorderSideColor: AppColors.redColor),
        focusedErrorBorder: outlineInputBorder(
          BorderSideColor: AppColors.redColor,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.normal16Grey,
        labelText: labelText,
        labelStyle: labelStyle,
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({required Color BorderSideColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: BorderSideColor,
        width: 1,
        style: BorderStyle.solid,
      ),
    );
  }
}
