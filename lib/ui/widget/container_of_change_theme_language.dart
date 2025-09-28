import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_providers .dart';
import '../../utlis/app_colors .dart';

class ContainerOfChangeThemeLanguage extends StatelessWidget {
  const ContainerOfChangeThemeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProviders>(context);
    return Container(
      width: width * 0.3,
      height: height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.darkBlueColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.002),
            child: GestureDetector(
              onTap: () {
                languageProvider.changeLanguage('en');
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: languageProvider.isEnglish()
                    ? AppColors.darkBlueColor
                    : AppColors.transparentColor,
                child: Flag(Flags.united_states_of_america, size: 24),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.002),
            child: GestureDetector(
              onTap: () {
                languageProvider.changeLanguage('ar');
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: languageProvider.isArabic()
                    ? AppColors.darkBlueColor
                    : AppColors.transparentColor,
                child: Flag(Flags.egypt, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
