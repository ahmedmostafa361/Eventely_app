import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/ui/tabs/Love_tab/love_tab_screen%20.dart';
import 'package:evently_app_flutter/ui/tabs/home_screen/home_screen%20.dart';
import 'package:evently_app_flutter/ui/tabs/map_tab/map_tab_screen%20.dart';
import 'package:evently_app_flutter/ui/tabs/profile_tab/profile_screen%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

class NavBarScreen extends StatefulWidget {
  NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<NavBarScreen> {
  int selectedIndex = 0;

  final selectedItem = [Icons.home, Icons.map, Icons.favorite, Icons.info];

  final unSelectedItem = [
    Icons.home_outlined,
    Icons.map_outlined,
    Icons.favorite_outline,
    Icons.info_outline,
  ];

  List<Widget> selectedWidget = [
    HomeScreen(),
    MapTabScreen(),
    LoveTabScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var labels = [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.map,
      AppLocalizations.of(context)!.love,
      AppLocalizations.of(context)!.profile
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: AppColors.whiteColor),
        shape: StadiumBorder(
          side: BorderSide(width: 6, color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.darkBlueColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /********************/
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        itemCount: selectedItem.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? selectedItem[index] : unSelectedItem[index],
                size: 24,
                color: AppColors.whiteColor,
              ),
              const SizedBox(height: 4),
              Text(labels[index], style: AppTextStyle.bold12White),
            ],
          );
        },

        activeIndex: selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => selectedIndex = index),

        //other params
      ),

      body: selectedWidget[selectedIndex],
    );
  }
}
