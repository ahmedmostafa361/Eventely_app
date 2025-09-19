import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_providers .dart';
import 'custom_drop_menu .dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProviders>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBlueColor,
          toolbarHeight: height * 0.18,
          title: Row(
            children: [
              languageProvider.isEnglish()
                  ? Image.asset(AppAssets.logo2)
                  : Container(
                height: height * 0.15,
                width: width * 0.28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        topLeft: Radius.circular(60)),
                    image: DecorationImage(
                        image: AssetImage(AppAssets.logo3), fit: BoxFit.fill)
                ),
              ),
              SizedBox(width: width * 0.04,),
              Container(
                height: height * 0.1,
                width: width * 0.5,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ahmed mostafa', style: AppTextStyle.bold24White,
                      textAlign: TextAlign.center
                      ,),
                    Expanded(child: Text(
                      'ahmedmostafa@gmail.com', style: AppTextStyle.bold16White,
                      softWrap: true,
                      overflow: TextOverflow.visible,))

                  ],
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomDropdown<String>(
                title: AppLocalizations.of(context)!.language,
                initialValue: languageProvider.appLanguage,
                entries: [
                  DropdownMenuEntry(
                    value: 'en',
                    label: AppLocalizations.of(context)!.english,
                  ),
                  DropdownMenuEntry(
                    value: 'ar',
                    label: AppLocalizations.of(context)!.arabic,
                  ),
                ],
                onSelected: (value) {
                  if (value != null) languageProvider.changeLanguage(value);
                },
              ),
              SizedBox(height: height * 0.03),

              CustomDropdown<ThemeMode>(
                key: ValueKey(AppLocalizations.of(context)!.localeName),
                title: AppLocalizations.of(context)!.theme,
                initialValue: themeProvider.appTheme,
                entries: [
                  DropdownMenuEntry(
                    value: ThemeMode.light,
                    label: AppLocalizations.of(context)!.light,
                  ),
                  DropdownMenuEntry(
                    value: ThemeMode.dark,
                    label: AppLocalizations.of(context)!.dark,
                  ),
                ],
                onSelected: (value) {
                  if (value != null) themeProvider.changeTheme(value);
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.logout, color: AppColors.whiteColor, size: 24),
                    SizedBox(width: width * 0.03),
                    Text(AppLocalizations.of(context)!.logout,
                        style: AppTextStyle.regular20White),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: AppColors.redColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
