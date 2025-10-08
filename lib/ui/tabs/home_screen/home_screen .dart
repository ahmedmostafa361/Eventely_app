import 'dart:async';

import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/ui/tabs/home_screen/tabs_items%20.dart';
import 'package:evently_app_flutter/ui/widget/event_list_item%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../fire_base_utils.dart';
import '../../../model/event.dart';
import '../../../providers/app_language_providers .dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  StreamSubscription? fireBaseDataList;
  List<Event> eventList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var languageProvider = Provider.of<AppLanguageProviders>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    var categoryIcons = [
      Icons.all_out_outlined, // Sport
      Icons.sports_basketball, // Sport
      Icons.cake, // Birthday
      Icons.groups, // Meeting
      Icons.videogame_asset, // Gaming
      Icons.handyman, // WorkShop
      Icons.menu_book, // Book Club
      Icons.photo, // Exhibition
      Icons.beach_access, // Holiday
      Icons.restaurant, // Eating
    ];
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.1,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.welcomeBack,
              style: AppTextStyle.medium14White,),
            Text(AppLocalizations.of(context)!.userName,
              style: AppTextStyle.bold24White,),
          ],
        ),
        actions: [
          Icon(themeProvider.isLightMode() ? Clarity.sun_line : Clarity
              .moon_line),
          SizedBox(width: width * 0.02,),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.0125,
                horizontal: width * 0.025
            ),
            margin: EdgeInsets.symmetric(
                vertical: height * 0.015,
                horizontal: width * 0.025
            ),
            child: Text(languageProvider.appLanguage.toUpperCase()),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.bgLight
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.125,
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined, color: AppColors.whiteColor,),
                    Text(AppLocalizations.of(context)!.userLocation,
                      style: AppTextStyle.medium14White,),
                  ],
                ),
                SizedBox(height: height * 0.02,),
                DefaultTabController(

                    length: eventNameList.length, child: TabBar(
                    isScrollable: true,
                    onTap: (index) {
                      selectedIndex = index;
                      setState(() {

                      });
                    },
                    labelPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    tabs: List.generate(eventNameList.length, (index) {
                      return TabsItems(
                          isSelected: selectedIndex == index,
                          eventName: eventNameList[index],
                        iconName: categoryIcons[index],
                        selectedColor: Theme
                            .of(context)
                            .canvasColor,
                        borderColor: Theme
                            .of(context)
                            .canvasColor,
                        selectedColorDarkM: AppColors.bgLight,
                        selectedColorLightM: AppColors.darkBlueColor,
                        unselectedColor: AppColors.bgLight,
                        styleSelectedColorDarkM: AppTextStyle.normal16White,
                        styleSelectedColorLightM: AppTextStyle.normal16DarkBlue,
                        styleUnselectedColor: AppTextStyle.normal16White,
                      );
                    },
                    )

                )
                ),
              ],
            ),
          ),
          Expanded(
            child: eventList.isEmpty ?
            Center(child: Text(
              'You didnt add Event yet', style: AppTextStyle.bold20DarkBlue,))
                : ListView.separated
              (
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.02,
                        right: width * 0.02,
                        top: height * 0.02
                    ),
                    child: EventListItem(event: eventList[index],),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0,);
                },
                itemCount: eventList.length
            ),
          )
        ],
      ),
    );
  }

  void getAllEvents() {
    fireBaseDataList =
        FireBaseUtils.getEventCollection().snapshots().listen((snapshot) {
          eventList = snapshot.docs.map((doc) {
            return doc.data();
          },
          ).toList();
          setState(() {

          });
        },
        );
  }

  @override
  void dispose() {
    fireBaseDataList?.cancel();
    super.dispose();
  }
/*

  Stream = Radio station (Firestore broadcasting updates)

  .listen() = Turn on your radio

  StreamSubscription = Your radio device

  .cancel() = Turn the radio off when leaving
   */
/*
  | Part              | Meaning                                             |
| ----------------- | --------------------------------------------------- |
| `snapshot`        | The whole Firestore result (QuerySnapshot)          |
| `snapshot.docs`   | List of all Firestore documents (DocumentSnapshots) |
| `doc.data()`      | Actual data inside a document                       |
| `.map(...)`       | Convert each document to an `Event`                 |
| `.toList()`       | Turn the mapped results into a Dart List            |
| `eventList = ...` | Save all events in memory for the UI                |
  */
}
