import 'package:evently_app_flutter/fire_base_utils.dart';
import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/model/my_users.dart';
import 'package:evently_app_flutter/ui/widget/container_of_change_theme_language.dart';
import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:evently_app_flutter/utlis/dialog_utlis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider .dart';
import '../providers/my_users_provider.dart';
import '../ui/widget/custom_text_form_field .dart';
import '../utlis/app_routes .dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController(
    text: 'ahmed',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'ahmed@gmail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  final formKey = GlobalKey<FormState>();
  final TextEditingController rePasswordController = TextEditingController(
    text: '123456',
  );

  bool showPassword = true;
  bool showConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
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
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(image: AssetImage(AppAssets.logoStarEvent)),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      prefixIcon: Icon(
                        Icons.person,
                        color: themeProvider.isLightMode()
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                        size: 24,
                      ),
                      hintText: AppLocalizations.of(context)!.name,
                      hintStyle: themeProvider.isLightMode()
                          ? AppTextStyle.normal16Grey
                          : AppTextStyle.normal16White,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_name;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(
                      controller: emailController,
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
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_email;
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(text);
                        if (!emailValid) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_valid_email;
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
                      obscureText: showPassword ? true : false,
                      obscuringCharacter: '*',
                      suffixIcon: IconButton(
                        icon: showPassword
                            ? Icon(Clarity.eye_hide_solid)
                            : Icon(Clarity.eye_show_solid),
                        onPressed: () {
                          showPassword = !showPassword;
                          setState(() {});
                        },
                        color: themeProvider.isLightMode()
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                      ),
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_password;
                        }
                        if (text.length < 6) {
                          return AppLocalizations.of(
                            context,
                          )!.password_too_short;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(
                      controller: rePasswordController,
                      prefixIcon: Icon(
                        Clarity.lock_solid,
                        color: themeProvider.isLightMode()
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                        size: 24,
                      ),
                      hintText: AppLocalizations.of(context)!.re_password,
                      hintStyle: themeProvider.isLightMode()
                          ? AppTextStyle.normal16Grey
                          : AppTextStyle.normal16White,
                      obscureText: showConfirmPassword ? true : false,
                      obscuringCharacter: '*',
                      suffixIcon: IconButton(
                        icon: showConfirmPassword ? Icon(
                          Clarity.eye_hide_solid,) : Icon(
                          Clarity.eye_show_solid,),
                        onPressed: () {
                          showConfirmPassword = !showConfirmPassword;
                          setState(() {

                          });
                        },
                        color: themeProvider.isLightMode()
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                      ),
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_email;
                        }
                        if (text != passwordController.text) {
                          return AppLocalizations.of(
                            context,
                          )!.password_not_match;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onPressed: () {
                        //nav to home screen
                        createAccount();
                      },
                      text: AppLocalizations.of(context)!.create_account,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.already_have_account,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            //nav to login screen
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: AppTextStyle.bold16DarkBlue.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.darkBlueColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ContainerOfChangeThemeLanguage(),
            ],
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtlis.loadingDialog(context);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUsers myUser = MyUsers(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FireBaseUtils.addUserToFireStore(myUser);
        var userProvider = Provider.of<MyUsersProvider>(context, listen: false);
        userProvider.updateUsers(myUser);
        DialogUtlis.hideDialog(context);
        DialogUtlis.showDialogMessage(
            context: context,
            middleText: 'Registered Successfully',
            buttonText: 'ok',
            pushOrPopNavigator: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.homeScreenRoute, (route) => false,
              );
            }
        );
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          print('error');
          DialogUtlis.hideDialog(context);
          DialogUtlis.showDialogMessage(title: 'Error',
              titleTextStyle: AppTextStyle.bold16Red,
              context: context,
              middleTextStyle: AppTextStyle.bold16Red,
              middleText: 'The password provided is too weak.',
              buttonText: 'ok');
        }
      } catch (error) {
        DialogUtlis.hideDialog(context);
        DialogUtlis.showDialogMessage(
            title: 'Error',
            titleTextStyle: AppTextStyle.bold16Red,
            context: context,
            middleText: error.toString(),
            buttonText: 'ok');
      }
      // Navigator.of(
      //   context,
      // ).pushNamedAndRemoveUntil(AppRoutes.homeScreenRoute, (route) => false);
    }
  }
}
