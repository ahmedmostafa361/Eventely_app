import 'package:evently_app_flutter/fire_base_utils.dart';
import 'package:evently_app_flutter/l10n/app_localizations.dart';
import 'package:evently_app_flutter/model/event.dart';
import 'package:evently_app_flutter/providers/my_users_provider.dart';
import 'package:evently_app_flutter/ui/widget/custom_elevated_button%20.dart';
import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:evently_app_flutter/utlis/dialog_utlis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  /// Opens Google Maps with real navigation to the event
  Future<void> openNavigation(double lat, double lng) async {
    // Try Google Maps app first, fallback to browser
    final googleMapsUrl =
    Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving');
    final googleMapsApp =
    Uri.parse('google.navigation:q=$lat,$lng&mode=d');

    if (await canLaunchUrl(googleMapsApp)) {
      await launchUrl(googleMapsApp);
    } else if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open maps application')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    final bool hasLocation = event.lat != null && event.long != null;

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
              Navigator.of(context)
                  .pushNamed(AppRoutes.eventEditScreen, arguments: event);
            },
            icon: Icon(Clarity.edit_line),
          ),
          IconButton(
            onPressed: () {
              deleteEvent(event);
              DialogUtlis.showDialogMessage(
                context: context,
                middleText: 'Event deleted Successfully',
                middleTextStyle: AppTextStyle.bold16Red,
                onButtonPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
            icon: Icon(Clarity.remove_line, color: AppColors.redColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Event cover image ──────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image(
                image: AssetImage(event.eventImage),
                height: height * 0.28,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Event name badge ───────────────────────────────
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlueColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(event.eventName,
                          style: AppTextStyle.normal16DarkBlue),
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  // ── Description ────────────────────────────────────
                  Text(
                    event.description,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                  SizedBox(height: height * 0.02),

                  // ── Date & Time card ───────────────────────────────
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
                          child: Icon(Clarity.calendar_line,
                              color: AppColors.whiteColor),
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
                            Text(event.eventTime,
                                style: AppTextStyle.bold14Black),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),

                  // ── Location section ───────────────────────────────
                  if (hasLocation) ...[
                    Text(
                      'Location',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                    SizedBox(height: height * 0.015),

                    // Address row
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.015),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlueColor.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.red, size: 22),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              event.address ?? 'Location saved',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.015),

                    // Mini map preview — shows where the event is
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: height * 0.25,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter:
                            LatLng(event.lat!, event.long!),
                            initialZoom: 15,
                            // Disable interaction so it's a preview only
                            interactionOptions: InteractionOptions(
                              flags: InteractiveFlag.none,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                              'com.example.evently_app_flutter',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(event.lat!, event.long!),
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // Get Directions button — opens real Google Maps navigation
                    ElevatedButton.icon(
                      onPressed: () => openNavigation(event.lat!, event.long!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlueColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: height * 0.018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(Icons.navigation_rounded, size: 20),
                      label: Text(
                        'Get Directions',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],

                  // If no location saved
                  if (!hasLocation)
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_off, color: Colors.grey),
                          SizedBox(width: 10),
                          Text('No location added for this event',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteEvent(Event event) async {
    var userProvider = Provider.of<MyUsersProvider>(context, listen: false);
    await FireBaseUtils.getEventCollection(userProvider.currentUser!.id)
        .doc(event.id)
        .delete();
  }
}