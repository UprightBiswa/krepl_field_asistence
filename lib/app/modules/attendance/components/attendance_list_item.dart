import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/constrants/constants.dart';
import '../model/attendance_data_model.dart';

class AttendanceListItem extends StatelessWidget {
  final AttendanceData data;

  const AttendanceListItem({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return PrimaryContainer(
      padding: EdgeInsets.zero,
      radius: 8,
      height: 50,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            decoration: const BoxDecoration(
              color: AppColors.kPrimary,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(DateTime.parse(data.checkinDate!)),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    DateFormat('dd').format(DateTime.parse(data.checkinDate!)),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Check In",
                  style: AppTypography.kMedium10.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
                Text(
                  data.checkinTime ?? '',
                  style: AppTypography.kBold12.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Check Out",
                  style: AppTypography.kMedium10.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
                Text(
                  data.checkoutTime ?? '',
                  style: AppTypography.kBold12.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
              ],
            ),
          ),
          if (data.attendanceSummaries.length > 2)
            IconButton(
              onPressed: () {
                if (data.attendanceSummaries.length > 2) {
                  _openRouteMap(data.attendanceSummaries);
                }
              },
              icon: const Icon(
                AppAssets.kLocation,
              ),
              iconSize: 24,
              splashRadius: 8,
            ),
        ],
      ),
    );
  }

  Future<void> _openRouteMap(List<AttendanceSummary> locations) async {
    // check  minimum number of routes to open 3
    if (locations.isEmpty || locations.length < 3) {
      Get.snackbar('Error', 'No locations to show on the map',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Construct the Google Maps URL
    final String origin =
        '${locations.first.latitude},${locations.first.longitude}';
    final String destination =
        '${locations.last.latitude},${locations.last.longitude}';
    final String waypoints = locations
        .skip(1) // Skip the first point (origin)
        .take(locations.length -
            2) // Take all points except the last (destination)
        .map((loc) => '${loc.latitude},${loc.longitude}')
        .join('|');

    // Construct the final URL
    final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1'
        '&origin=$origin'
        '&destination=$destination'
        '&waypoints=$waypoints';
    // for ios, we need to

    final Uri googleMapsUri = Uri.parse(googleMapsUrl);

    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri);
      } else {
        throw 'Could not launch Google Maps';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to open map: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
