import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsItems extends StatelessWidget {
  const TabsItems({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.iconName,
    required this.selectedColor,
    required this.borderColor,
    required this.selectedColorDarkM,
    required this.selectedColorLightM,
    required this.unselectedColor,
    required this.styleSelectedColorDarkM,
    required this.styleSelectedColorLightM,
    required this.styleUnselectedColor
  });

  final bool isSelected;
  final String eventName;
  final IconData iconName;
  final Color selectedColor;
  final Color borderColor;
  final Color selectedColorDarkM;
  final Color selectedColorLightM;
  final Color unselectedColor;
  final TextStyle styleSelectedColorDarkM;
  final TextStyle styleSelectedColorLightM;
  final TextStyle styleUnselectedColor;
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
            ? selectedColor
            : AppColors.transparentColor,
        border: Border.all(color: borderColor, width: 1.5),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconName,
            color: isSelected
                ? (themeProvider.isDarkMode()
                ? selectedColorDarkM //selectedColorDarkM
                : selectedColorLightM) //selectedColorLightM
                : unselectedColor, //unselectedColor

            // isSelected?AppColors.darkBlueColor:AppColors.bgLight,
          ),
          SizedBox(width: width * 0.01),
          Text(
            eventName,
            style: isSelected
                ? (themeProvider.isDarkMode()
                ? styleSelectedColorDarkM
            // AppTextStyle.normal16White
                : styleSelectedColorLightM)
                : styleUnselectedColor
          ),
        ],
      ),
    );
  }
}
