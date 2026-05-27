import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/model/my_users.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/providers/my_users_provider.dart';
import 'package:evently_app_flutter/ui/widget/container_of_change_theme_language.dart';
import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/ui/widget/custom_text_form_field%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../fire_base_utils.dart';
import '../utlis/dialog_utlis.dart';

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
                          signInWithGoogle();
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

  void login() async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtlis.loadingDialog(context);

        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FireBaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<MyUsersProvider>(context, listen: false);
        userProvider.updateUsers(user);
        DialogUtlis.hideDialog(context);
        DialogUtlis.showDialogMessage(context: context,
            middleText: 'Login Successfully',
            buttonText: 'ok',
          onButtonPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.homeScreenRoute, (route) => false,);
          },

          // pushOrPopNavigator: () {
          //
          // }
        );
      } on FirebaseAuthException catch (error) {
        if (error.code == 'invalid-credential') {
          DialogUtlis.hideDialog(context);
          DialogUtlis.showDialogMessage(title: 'Error',
              middleTextStyle: AppTextStyle.bold16Red,
              titleTextStyle: AppTextStyle.bold16Red,
              context: context,
              middleText: 'The Email Or Password is incorrect',
              buttonText: 'ok');
        }
      } catch (error) {
        DialogUtlis.hideDialog(context);
        DialogUtlis.showDialogMessage(
            title: 'Error',
            context: context,
            middleText: error.toString(),
            buttonText: 'ok');
      }
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //   AppRoutes.homeScreenRoute, (route) => false,);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      DialogUtlis.loadingDialog(context);

      // Sign out first to force the account picker to appear
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        DialogUtlis.hideDialog(context);
        return;
      }

      final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // ✅ Only one signInWithCredential call
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      MyUsers? user =
      await FireBaseUtils.readUserFromFireStore(firebaseUser!.uid);
      if (user == null) {
        user = MyUsers(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
        );
      }

      final userProvider =
      Provider.of<MyUsersProvider>(context, listen: false);
      userProvider.updateUsers(user);

      DialogUtlis.hideDialog(context);
      DialogUtlis.showDialogMessage(
        context: context,
        middleText: 'Login Successfully with Google',
        buttonText: 'OK',
        onButtonPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeScreenRoute,
                (route) => false,
          );
        },
      );
    } catch (e) {
      DialogUtlis.hideDialog(context);
      DialogUtlis.showDialogMessage(
        title: 'Error',
        context: context,
        middleText: e.toString(),
        middleTextStyle: AppTextStyle.bold16Red,
        buttonText: 'OK',
      );
    }
  }
}

