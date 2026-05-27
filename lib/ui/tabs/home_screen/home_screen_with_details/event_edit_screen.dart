import 'package:evently_app_flutter/fire_base_utils.dart';
import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/ui/tabs/home_screen/tabs_items%20.dart';
import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/ui/widget/custom_text_form_field%20.dart';
import 'package:evently_app_flutter/ui/widget/event_time_row%20.dart';
import 'package:evently_app_flutter/utlis/app_assets%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:evently_app_flutter/utlis/dialog_utlis.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../model/event.dart';
import '../../../../providers/app_theme_provider .dart';
import '../../../../providers/my_users_provider.dart';

class EventEditScreen extends StatefulWidget {
  const EventEditScreen({super.key});

  @override
  State<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {

  TextEditingController titleController = TextEditingController(text: 'event');
  TextEditingController descriptionController = TextEditingController(
    text: 'desc ',
  );
  int selectedIndex = 0;
  DateTime? selectedDate;
  String formattedDate = '';
  TimeOfDay? selectedTime;
  String formattedTime = '';
  bool checkErrorOfChooseDate = false;
  final formKey = GlobalKey<FormState>();
  List<String> imagesList = [
    AppAssets.sport,
    AppAssets.birthday1,
    AppAssets.meeting,
    AppAssets.gaming,
    AppAssets.workshop,
    AppAssets.bookClub,
    AppAssets.exhibition,
    AppAssets.holiday,
    AppAssets.eating,
  ];
  Event? event;

  @override
  void initState() {
    ///initState() runs only once, when the widget is first created.
    super.initState();
    // delay reading ModalRoute until build context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// why use widget binding This tells Flutter: This tells Flutter:  wait until the first frame is built, then safely get the route arguments

      event = ModalRoute.of(context)!.settings.arguments as Event;
      titleController.text = event!.title;
      descriptionController.text = event!.description;
      formattedDate = DateFormat('dd/MM/yyyy').format(event!.eventDataTime);
      selectedDate = event!.eventDataTime;
      formattedTime = event!.eventTime;
      selectedTime = TimeOfDay.fromDateTime(event!.eventDataTime);
      selectedIndex = imagesList.indexOf(event!.eventImage);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> eventNameList = [
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<MyUsersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.darkBlueColor),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.createEvent,
          style: AppTextStyle.normal20DarkBlue,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.04,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: Image(image: AssetImage(imagesList[selectedIndex])),
                ),
                Container(
                  height: height * 0.1,
                  child: DefaultTabController(
                    length: eventNameList.length,
                    child: TabBar(
                      onTap: (index) {
                        selectedIndex = index;
                        setState(() {});
                      },
                      tabs: List.generate(eventNameList.length, (index) {
                        return TabsItems(
                          isSelected: selectedIndex == index,
                          eventName: eventNameList[index],
                          iconName: categoryIcons[index],
                          selectedColor: AppColors.darkBlueColor,
                          borderColor: AppColors.darkBlueColor,
                          selectedColorDarkM: AppColors.blackColor,
                          selectedColorLightM: AppColors.bgLight,
                          unselectedColor: AppColors.darkBlueColor,
                          styleSelectedColorDarkM: AppTextStyle.bold16Black,
                          styleSelectedColorLightM: AppTextStyle.normal16White,
                          styleUnselectedColor: AppTextStyle.normal16DarkBlue,
                        );
                      }),
                      labelPadding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: AppColors.transparentColor,
                      dividerColor: AppColors.transparentColor,
                      isScrollable: true,
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                CustomTextFormField(
                  prefixIcon: Icon(Clarity.note_edit_line),
                  hintText: AppLocalizations.of(context)!.eventTitle,
                  controller: titleController,
                  hintStyle: themeProvider.isLightMode()
                      ? AppTextStyle.normal16Grey
                      : AppTextStyle.normal16White,
                  validator: (text) {
                    ///title validation
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.enterTitle;
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.eventDescription,
                  hintStyle: themeProvider.isLightMode()
                      ? AppTextStyle.normal16Grey
                      : AppTextStyle.normal16White,
                  maxLines: 4,
                  controller: descriptionController,

                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.enterDescription;
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                EventTimeRow(
                  firstText: AppLocalizations.of(context)!.eventDate,
                  secondText: selectedDate == null
                      ? AppLocalizations.of(context)!.chooseDate
                      : formattedDate,
                  icon: Clarity.calendar_line,
                  onPressed: () {
                    chooseDate();
                  },
                ),
                checkErrorOfChooseDate && selectedDate == null
                    ? Text(
                        AppLocalizations.of(context)!.plsChooseDate,
                        style: AppTextStyle.bold10Red,
                      )
                    : SizedBox(),
                EventTimeRow(
                  firstText: AppLocalizations.of(context)!.eventTime,
                  secondText: selectedTime == null
                      ? AppLocalizations.of(context)!.chooseTime
                      : formattedTime,
                  icon: Clarity.clock_line,
                  onPressed: () {
                    ///change time
                    chooseTime();
                  },
                ),
                checkErrorOfChooseDate && selectedTime == null
                    ? Text(
                        AppLocalizations.of(context)!.plsChooseTime,
                        style: AppTextStyle.bold10Red,
                      )
                    : SizedBox(),
                SizedBox(height: height * 0.01),

                Text(
                  AppLocalizations.of(context)!.location,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  onPressed: () {
                    ///choose event location
                  },
                  hasIcon: true,
                  borderSideColor: AppColors.darkBlueColor,
                  backgroundColor: AppColors.transparentColor,
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.008,
                    horizontal: width * 0.02,
                  ),
                  customInButton: Row(
                    children: [
                      Container(
                        height: height * 0.06,
                        width: width * 0.125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.darkBlueColor,
                        ),
                        child: Icon(
                          FontAwesome.map_pin_solid,
                          color: themeProvider.isLightMode()
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),

                      SizedBox(width: width * 0.02),
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: AppTextStyle.normal16DarkBlue,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.darkBlueColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  onPressed: () {
                    /// add event ***********************************
                    checkValidation(eventNameList[selectedIndex],
                        userProvider.currentUser!.id);
                    setState(() {});
                  },
                  text: AppLocalizations.of(context)!.updateDetails,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkValidation(String eventNameList, String id) {
    if (formKey.currentState?.validate() == true) {
      if (selectedTime != null && selectedDate != null) {
        try {
          Event currentEvent =
              ModalRoute.of(context)!.settings.arguments as Event;
          Event updateEvent = Event(
            id: currentEvent.id,
            title: titleController.text,
            description: descriptionController.text,
            eventImage: imagesList[selectedIndex],
            eventName: eventNameList,
            eventTime: formattedTime.isNotEmpty
                ? formattedTime
                : currentEvent.eventTime,
            eventDataTime: selectedDate ?? currentEvent.eventDataTime,
          );
          FireBaseUtils.updateEvent(updateEvent, id);
          DialogUtlis.showDialogMessage(
            context: context,
            middleText: 'Update Worked :)',
            title: 'Success Operation!',
            titleTextStyle: AppTextStyle.normal20DarkBlue,
            onButtonPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.homeScreenRoute);
            },

          );
        } catch (error) {
          DialogUtlis.showDialogMessage(
            context: context,
            middleText: 'Update Failed : $error',
          );
        }
        return;
      }
    }
    setState(() {
      checkErrorOfChooseDate = true;
    });
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 8)),
    );
    selectedDate = chooseDate;
    if (selectedDate != null) {
      formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if (selectedTime != null) {
      formattedTime = selectedTime!.format(context);
    }
    setState(() {});
  }
}
