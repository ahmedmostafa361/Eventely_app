import 'dart:async';

import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

import '../../../fire_base_utils.dart';
import '../../../model/event.dart';
import '../../widget/event_list_item .dart';

class LoveTabScreen extends StatefulWidget {
  const LoveTabScreen({super.key});

  @override
  State<LoveTabScreen> createState() => _LoveTabScreenState();
}

class _LoveTabScreenState extends State<LoveTabScreen> {
  List<Event> favoriteList = [];
  StreamSubscription? fireBaseDataList;
  List<Event> eventList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFavoriteEvents();
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
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.02),
      child: SafeArea(
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Search for Event',
                hintStyle: AppTextStyle.bold14DarkBlue,
                prefixIcon: Icon(
                  Icons.search_outlined, color: AppColors.darkBlueColor,
                  size: 24,),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        width: 2, color: AppColors.darkBlueColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        width: 2, color: AppColors.darkBlueColor))
            ),
          ),
          SizedBox(height: height * 0.012,),
          Expanded(
            child: ListView.separated
              (
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.02,
                        right: width * 0.02,
                        top: height * 0.02
                    ),
                    child: EventListItem(event: favoriteList[index],),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.01,);
                },
                itemCount: favoriteList.length
            ),
          )
        ],

        ),
      ),
    );
  }

  void getAllFavoriteEvents() {
    fireBaseDataList =
        FireBaseUtils
            .getEventCollection()
            .orderBy('eventDataTime')
            .snapshots()
            .listen((snapshot) {
          eventList = snapshot.docs.map((doc) {
            return doc.data();
          },).toList();
          favoriteList = eventList.where((event) {
            return event.isFavorite == true;
          },).toList();
          setState(() {

          });
        });
  }

  @override
  void dispose() {
    fireBaseDataList?.cancel();
    super.dispose();
  }
}
