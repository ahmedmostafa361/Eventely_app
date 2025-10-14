import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/model/event.dart';
import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:evently_app_flutter/utlis/dialog_utlis.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.darkBlueColor),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.eventDetails,
          style: AppTextStyle.normal20DarkBlue,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ///edit event *******
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.eventEditScreen, arguments: event);
            },
            icon: Icon(Clarity.edit_line),
          ),
          IconButton(
            onPressed: () {
              ///delete event
              deleteEvent(event);
              DialogUtlis.showDialogMessage(
                context: context,
                middleText: 'Event deleted Successfully',
                pushOrPopNavigator: () {
                  Navigator.of(context).pop();
                },
              );
            },
            icon: Icon(Clarity.remove_line, color: AppColors.redColor),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image(image: AssetImage(event.eventImage)),
              ),
              SizedBox(height: height * 0.02),
              Text(event.description),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                onPressed: () {},
                backgroundColor: AppColors.transparentColor,
                borderSideColor: AppColors.darkBlueColor,
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                hasIcon: true,
                customInButton: Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: AppColors.darkBlueColor,
                      child: Icon(
                        Clarity.calendar_line,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yMd').format(event.eventDataTime),
                          style: AppTextStyle.bold16DarkBlue,
                        ),
                        SizedBox(height: height * 0.005),
                        Text(event.eventTime, style: AppTextStyle.bold14Black),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteEvent(Event event) {
    FirebaseFirestore.instance
        .collection(Event.collectionName)
        .doc(event.id)
        .delete();
  }
}
