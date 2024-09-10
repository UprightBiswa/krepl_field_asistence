import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../../repository/firebase/notification_model.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  final int index;
  const NotificationCard(
      {required this.notification, required this.index, super.key});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool startAnimation = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (widget.index * 200)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : Get.width, 0, 0),
      child: Row(
        children: [
          Container(
            height: 55.h,
            width: 55.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.kAccent2),
            child: const Icon(
              AppAssets.kNotifications,
             
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.notification.notificationAbout,
                  style: AppTypography.kMedium16.copyWith(
                      color: isDarkMode(context)
                          ? AppColors.kWhite
                          : Colors.black),
                ),
                SizedBox(height: 5.h),
                Text(
                  widget.notification.notificationMessage,
                  style: AppTypography.kMedium16
                      .copyWith(color: const Color(0xFF9A9FA5)),
                ),
                SizedBox(height: 5.h),
                Text(
                  CustomDateTimeFormat.notificationDateFormat(
                      widget.notification.notificationTime),
                  style: AppTypography.kLight14
                      .copyWith(color: AppColors.kSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CustomDateTimeFormat {
  static String notificationDateFormat(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference < const Duration(minutes: 1)) {
      return 'Just Now';
    } else if (difference < const Duration(hours: 1)) {
      return DateFormat('h:mm a').format(date);
    } else if (difference < const Duration(days: 1)) {
      return DateFormat('h:mm a').format(date);
    } else if (difference < const Duration(days: 7)) {
      return '${DateFormat('EEEE, MMM d').format(date)} at ${DateFormat('h:mm a').format(date)}';
    } else {
      return '${DateFormat('MMM d, y').format(date)} at ${DateFormat('h:mm a').format(date)}';
    }
  }

  static String timeFormat(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }
}
