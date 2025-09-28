import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/ui/widget/container_of_change_theme_language.dart';
import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/ui/widget/custom_text_form_field%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(
      text: 'ahmed@gmail.com');
  final TextEditingController passwordController = TextEditingController(
      text: '123456');


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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.logoStarEvent),
                SizedBox(height: height * 0.02),
                Form(
                  key: formKey,
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
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_email;
                          }
                          final bool emailValid =
                          RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .please_enter_valid_email;
                          }
                          return null;
                        },

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
                        controller: passwordController,
                        obscuringCharacter: '*',
                        obscureText: true,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_password;
                          }
                          if (text.length < 6) {
                            return AppLocalizations.of(context)!
                                .password_too_short;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.005),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.resetPassScreen);
                          },
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
                          return login();
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
                              Navigator.of(context).pushNamed(
                                  AppRoutes.registerScreen);
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
                ContainerOfChangeThemeLanguage()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.homeScreenRoute, (route) => false,);
    }
  }
}
