import 'package:flutter/material.dart';
import 'package:evently_app_flutter/model/event.dart';
import 'package:evently_app_flutter/utlis/app_colors .dart';

class MapEventItem extends StatelessWidget {
  final Event eventModel;
  final String? travelTime;

  const MapEventItem({super.key, required this.eventModel, this.travelTime});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final double cardWidth = width * 0.70;
    final double cardHeight = height * 0.17;
    final double imageWidth = cardWidth * 0.35; // 35% of card for image

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: cardWidth,
        height: cardHeight, // ← card has a FIXED height
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            // ── IMAGE drawn as positioned fill on left side ────────────
            // Using Positioned instead of Row child removes ALL Row
            // layout constraints — image gets exact pixels, no slicing
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: imageWidth,
              // ← exact pixel width
              child: Image.asset(
                eventModel.eventImage,
                fit: BoxFit.contain, // fills its exact box — no slicing
              ),
            ),

            // ── Gradient overlay so text is readable over image ────────
            Positioned(
              top: 0,
              bottom: 0,
              left: imageWidth - 20,
              // slight overlap for smooth fade
              width: 20,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Theme.of(context).cardColor],
                  ),
                ),
              ),
            ),

            // ── INFO SECTION positioned to the right of image ──────────
            Positioned(
              top: 0,
              bottom: 0,
              left: imageWidth,
              // starts right after the image
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.022,
                  vertical: height * 0.010,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Category badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlueColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        eventModel.eventName,
                        style: TextStyle(
                          fontSize: width * 0.027,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlueColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Title
                    Text(
                      eventModel.title,
                      style: TextStyle(
                        fontSize: width * 0.034,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleSmall?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Event time
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: width * 0.032,
                          color: AppColors.darkBlueColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          eventModel.eventTime,
                          style: TextStyle(
                            fontSize: width * 0.028,
                            color: AppColors.darkBlueColor,
                          ),
                        ),
                      ],
                    ),

                    // Travel time badge
                    if (travelTime != null)
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                            size: width * 0.032,
                            color: Colors.green,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '$travelTime away',
                            style: TextStyle(
                              fontSize: width * 0.028,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                    // Address
                    if (eventModel.address != null &&
                        eventModel.address!.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: width * 0.032,
                            color: Colors.red,
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              eventModel.address!,
                              style: TextStyle(
                                fontSize: width * 0.025,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
