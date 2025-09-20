import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsItems extends StatelessWidget {
  const TabsItems({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.iconName,
  });

  final bool isSelected;
  final String eventName;
  final IconData iconName;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      // height: height*0.1,
      // width: width*0.3,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.012,
      ),
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isSelected
            ? Theme.of(context).canvasColor
            : AppColors.transparentColor,
        border: Border.all(color: Theme.of(context).canvasColor, width: 1.5),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconName,
            color: isSelected
                ? (themeProvider.isDarkMode()
                      ? AppColors.bgLight
                      : AppColors.darkBlueColor)
                : AppColors.bgLight,

            // isSelected?AppColors.darkBlueColor:AppColors.bgLight,
          ),
          SizedBox(width: width * 0.01),
          Text(
            eventName,
            style: isSelected
                ? (themeProvider.isDarkMode()
                      ? AppTextStyle.normal16White
                      : AppTextStyle.normal16DarkBlue)
                : AppTextStyle.normal16White,
          ),
        ],
      ),
    );
  }
}
