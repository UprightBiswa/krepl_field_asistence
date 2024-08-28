import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';

class TodayStatusCard extends StatelessWidget {
  final String employeeName;
  final String checkInTime;
  final String checkOutTime;
  final String currentAddress;

  const TodayStatusCard({super.key, 
    required this.employeeName,
    required this.checkInTime,
    required this.checkOutTime,
    required this.currentAddress,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PrimaryContainer(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $employeeName 👋',
              style: AppTypography.kMedium14.copyWith(color: AppColors.kGrey),
            ),
            SizedBox(height: 4.h),
            Text(
              "Today's Status",
              style: AppTypography.kMedium14.copyWith(fontFamily: 'NexaBold'),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Text(
                  'Check In: $checkInTime',
                  style: AppTypography.kLight12.copyWith(color: AppColors.kGrey),
                ),
                const Spacer(),
                Text(
                  'Check Out: $checkOutTime',
                  style: AppTypography.kLight12.copyWith(color: AppColors.kGrey),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            RichText(
              text: TextSpan(
                text: DateTime.now().day.toString(),
                style: AppTypography.kBold24.copyWith(
                    color: AppColors.kAccent1, fontFamily: 'NexaBold'),
                children: [
                  TextSpan(
                    text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                    style: AppTypography.kBold16.copyWith(
                      color: isDarkMode ? AppColors.kWhite : AppColors.kGrey,
                      fontFamily: 'NexaBold',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: AppTypography.kLight14.copyWith(
                      color: isDarkMode ? AppColors.kWhite : AppColors.kGrey,
                      fontFamily: 'NexaBold',
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 8.h),
            Text(
              'Location: $currentAddress',
              style: AppTypography.kMedium14.copyWith(color: AppColors.kGrey),
            ),
          ],
        ),
      ),
    );
  }
}
