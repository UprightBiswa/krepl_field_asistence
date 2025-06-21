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
    String getGreeting() {
      final now = DateTime.now();
      final hour = now.hour;

      if (hour < 12) {
        return 'Good Morning';
      } else if (hour < 18) {
        return 'Good Afternoon';
      } else if (hour < 21) {
        return 'Good Evening';
      } else {
        return 'Good Night';
      }
    }

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
                Text(
                  '${getGreeting()}, 👋',
                  style:
                      AppTypography.kMedium16.copyWith(color: AppColors.kGrey),
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.kAccent1.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.kAccent1),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor:
                                  AppColors.kAccent1.withValues(alpha: 0.2),
                              child: const Icon(Icons.check,
                                  color: AppColors.kAccent1),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Check In',
                                    style: AppTypography.kBold12,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    todayStatus.checkinTime ?? '--/--',
                                    style: AppTypography.kLight12
                                        .copyWith(color: AppColors.kAccent1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.kAccent2.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.kAccent2),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor:
                                  AppColors.kAccent2.withValues(alpha: 0.2),
                              child: const Icon(Icons.check,
                                  color: AppColors.kAccent2),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Check Out',
                                    style: AppTypography.kBold12,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    todayStatus.checkoutTime ?? '--/--',
                                    style: AppTypography.kLight12
                                        .copyWith(color: AppColors.kAccent2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
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
