import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
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
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.kPrimary,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('E')
                          .format(DateTime.parse(data.checkinDate!)),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      DateFormat('dd')
                          .format(DateTime.parse(data.checkinDate!)),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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
          Expanded(
            child: IconButton(
              onPressed: () {
                if (data.checkinLat != 'null' &&
                    data.checkinLong != 'null' &&
                    data.checkoutLat != 'null' &&
                    data.checkoutLong != 'null') {
                  _launchMap(
                    double.parse(data.checkinLat.toString()),
                    double.parse(data.checkinLong.toString()),
                    double.parse(data.checkoutLat.toString()),
                    double.parse(data.checkoutLong.toString()),
                  );
                }
              },
              icon: const Icon(
                AppAssets.kLocation,
              ),
              iconSize: 24,
              splashRadius: 8,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchMap(double checkinLat, double checkinLong,
      double checkoutLat, double checkoutLong) async {
    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$checkinLat,$checkinLong&destination=$checkoutLat,$checkoutLong';
    String appleMapsUrl =
        'https://maps.apple.com/?saddr=$checkinLat,$checkinLong&daddr=$checkoutLat,$checkoutLong';

    Uri googleMapsUri = Uri.parse(googleMapsUrl);
    Uri appleMapsUri = Uri.parse(appleMapsUrl);

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else if (await canLaunchUrl(appleMapsUri)) {
      await launchUrl(appleMapsUri);
    } else {
      throw 'Could not launch map';
    }
  }
}
