import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.darkBlueColor,
    scaffoldBackgroundColor: AppColors.bgLight,
      canvasColor: AppColors.bgLight,
    cardColor: AppColors.blackColor,

    textTheme: TextTheme(
      headlineLarge: AppTextStyle.bold20Black,
      headlineMedium: AppTextStyle.bold16Black,
      bodyMedium: AppTextStyle.bold16Black,
        labelMedium: AppTextStyle.normal16Grey
    ),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.darkBlueColor

      ),
    iconTheme: IconThemeData(
        color: AppColors.blackColor
    ),



  );
  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.navBarDarkModeColor,
    scaffoldBackgroundColor: AppColors.bgDark,
      canvasColor: AppColors.darkBlueColor,
      cardColor: AppColors.bgLight,

      textTheme: TextTheme(
      headlineLarge: AppTextStyle.bold20White,
      headlineMedium: AppTextStyle.bold16White,
      bodyMedium: AppTextStyle.bold16White,
          labelMedium: AppTextStyle.normal16White

      ),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.navBarDarkModeColor
      ),
      iconTheme: IconThemeData(
          color: AppColors.bgLight
      )

  );
}
