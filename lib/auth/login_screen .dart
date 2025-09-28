import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/ui/widget/custom_text_form_field%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.02,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.logoStarEvent),
              SizedBox(height: height * 0.02),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.email,
                        color: themeProvider.isLightMode()
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                        size: 24,
                      ),
                      hintText: AppLocalizations.of(context)!.email,
                      hintStyle: themeProvider.isLightMode()
                          ? AppTextStyle.normal16Grey
                          : AppTextStyle.normal16White,
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Clarity.lock_solid,
                        color: themeProvider.isLightMode()
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                        size: 24,
                      ),
                      hintText: AppLocalizations.of(context)!.password,
                      hintStyle: themeProvider.isLightMode()
                          ? AppTextStyle.normal16Grey
                          : AppTextStyle.normal16White,
                    ),
                    SizedBox(height: height * 0.005),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.forgot_password,
                          style: AppTextStyle.bold16DarkBlue.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.darkBlueColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onPressed: () {
                        //nav to home screen
                      },
                      text: AppLocalizations.of(context)!.login,
                    ),
                    SizedBox(height: height * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.dont_have_account),
                        TextButton(
                          onPressed: () {
                            //navigate to register screen
                          },
                          child: Text(
                            AppLocalizations.of(context)!.create_account,
                            style: AppTextStyle.bold16DarkBlue.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.darkBlueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.015),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.darkBlueColor,
                            indent: width * 0.04,
                            endIndent: width * 0.03,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.or,
                          style: AppTextStyle.normal16DarkBlue,
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.darkBlueColor,
                            indent: width * 0.04,
                            endIndent: width * 0.03,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onPressed: () {
                        // login with google
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.registerScreen);
                      },
                      hasIcon: true,
                      borderSideColor: AppColors.darkBlueColor,
                      backgroundColor: AppColors.transparentColor,
                      customInButton: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Brand(Brands.google, size: 26),
                          SizedBox(width: width * 0.02),
                          Text(
                            AppLocalizations.of(context)!.login_with_google,
                            style: AppTextStyle.normal20DarkBlue,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
