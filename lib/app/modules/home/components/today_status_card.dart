import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/login/user_details_reponse.dart';
import '../../attendance/attendance_view_page.dart';
import '../../attendance/controller/attendance_controller.dart';
import '../../widgets/containers/primary_container.dart';

class TodayStatusCard extends StatefulWidget {
  final UserDetails userDetails;
  const TodayStatusCard({
    required this.userDetails,
    super.key,
  });

  @override
  State<TodayStatusCard> createState() => _TodayStatusCardState();
}

class _TodayStatusCardState extends State<TodayStatusCard> {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  @override
  void initState() {
    super.initState();
    attendanceController.fetchTodayStatus();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      var todayStatus = attendanceController.todayStatus.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Status",
            style: AppTypography.kBold16,
          ),
          SizedBox(height: 10.h),
          PrimaryContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check-In ',
                          style: AppTypography.kLight14
                              .copyWith(color: AppColors.kGrey),
                        ),
                        Text(
                          todayStatus.checkinTime ?? '--/--',
                          style: AppTypography.kLight14.copyWith(
                            color: AppColors.kPrimary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check-Out',
                          style: AppTypography.kLight14.copyWith(
                            color: AppColors.kGrey,
                          ),
                        ),
                        Text(
                          todayStatus.checkoutTime ?? '--/--',
                          style: AppTypography.kLight14.copyWith(
                            color: AppColors.kPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                CustomSwipeButton(
                  title: 'Attendance',
                  subtitle: 'Swipe to view Attendance',
                  onSwipe: () {
                    Get.to(
                      () => AttendanceViewPage(userDetails: widget.userDetails),
                      transition: Transition.rightToLeft,
                    );
                    // showModalBottomSheet<void>(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   backgroundColor: Colors.transparent,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(30.r),
                    //     ),
                    //   ),
                    //   builder: (context) {
                    //     return const ReferFriendSheet();
                    //   },
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
