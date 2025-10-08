import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/event.dart';

class EventListItem extends StatelessWidget {
  final Event event;

  const EventListItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: height * 0.255,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          style: BorderStyle.solid,
          color: AppColors.darkBlueColor,
          width: 2,
        ),
        image: DecorationImage(
          image: AssetImage(event.eventImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.022,
              vertical: height * 0.002,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat('d').format(event.eventDataTime),
                    style: AppTextStyle.bold20DarkBlue),
                Text(DateFormat('MMM').format(event.eventDataTime),
                    style: AppTextStyle.bold14DarkBlue),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: height * 0.01,
                horizontal: width * 0.015,
              ),
              padding: EdgeInsets.symmetric(
                vertical: height * 0.01,
                horizontal: width * 0.02,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: themeProvider.isLightMode()
                          ? AppTextStyle.bold14Black
                          : AppTextStyle.bold14White,
                    ),
                  ),
                  Icon(Icons.favorite_outline, color: AppColors.darkBlueColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
