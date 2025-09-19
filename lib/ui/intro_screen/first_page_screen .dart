import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/providers/app_language_providers%20.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/ui/intro_screen/selector_row_of_first_page%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstPageScreen extends StatefulWidget {
  const FirstPageScreen({super.key});

  @override
  State<FirstPageScreen> createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProviders>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image(image: AssetImage(AppAssets.logo)),
            ),
            SizedBox(height: height * 0.03),

            Image(
              image: AssetImage(AppAssets.onBoard1),
              height: height * 0.429,
              width: double.infinity,
            ),
            SizedBox(height: height * 0.015),

            Text(
              'Personalize Your Experience',
              style: AppTextStyle.bold20DarkBlue,
            ),
            SizedBox(height: height * 0.015),

            Text(
              AppLocalizations.of(context)!.pg1t1,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.02),

            SelectorRow(
              title: AppLocalizations.of(context)!.language,
              width: width,
              height: height,
              children: [
                CircleOptionButton(
                  isActive: !languageProvider.isEnglish(),
                  image: AppAssets.egypt,
                  onTap: () => languageProvider.changeLanguage('ar'),
                ),
                CircleOptionButton(
                  isActive: languageProvider.isEnglish(),
                  image: AppAssets.america,
                  onTap: () => languageProvider.changeLanguage('en'),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),

            SelectorRow(
              title: AppLocalizations.of(context)!.theme,
              width: width,
              height: height,
              children: [
                CircleOptionButton(
                  isActive: themeProvider.isLightMode(),
                  image: AppAssets.lightMode,
                  onTap: () => themeProvider.changeTheme(ThemeMode.light),
                ),
                CircleOptionButton(
                  isActive: !themeProvider.isLightMode(),
                  image: AppAssets.darkMode,
                  onTap: () => themeProvider.changeTheme(ThemeMode.dark),
                  colorFilter: themeProvider.isLightMode()
                      ? AppColors.darkBlueColor
                      : AppColors.whiteColor,
                ),
              ],
            ),
            SizedBox(height: height * 0.02),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.introScreenRoute);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: AppColors.darkBlueColor,
              ),
              child: Text(
                AppLocalizations.of(context)!.pg1b1,
                style: AppTextStyle.regular20White,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
