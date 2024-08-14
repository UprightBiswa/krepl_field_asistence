import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/login/user_details_reponse.dart';
import '../../widgets/containers/primary_container.dart';

class TodayStatusCard extends StatelessWidget {
  final UserDetails userDetails;
  const TodayStatusCard({
    required this.userDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return PrimaryContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Status",
            style: AppTypography.kBold16,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check-In ',
                    style:
                        AppTypography.kLight14.copyWith(color: AppColors.kGrey),
                  ),
                  Text(
                    '09:00 AM', // Example check-in time
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
                    '06:00 PM', // Example check-out time
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
    );
  }
}
