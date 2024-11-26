import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';

class TodayStatusCard extends StatelessWidget {
  final String empCode;
  final String employeeName;
  final String checkInTime;
  final String checkOutTime;
  final String currentAddress;

  const TodayStatusCard({
    super.key,
    required this.empCode,
    required this.employeeName,
    required this.checkInTime,
    required this.checkOutTime,
    required this.currentAddress,
  });

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

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Status",
            style: AppTypography.kMedium16,
          ),

          SizedBox(height: 10.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${getGreeting()}, 👋',
                style: AppTypography.kMedium16.copyWith(color: AppColors.kGrey),
              ),
              SizedBox(
                width: 10.w,
              ),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppColors.kAccent1.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: AppTypography.kLight14.copyWith(
                        color: AppColors.kAccent1,
                      ),
                    ),
                  );
                },
              ),
            ],
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
                    color: AppColors.kAccent1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.kAccent1),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.kAccent1.withOpacity(0.2),
                        child:
                            const Icon(Icons.check, color: AppColors.kAccent1),
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
                              checkInTime,
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
                    color: AppColors.kAccent2.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.kAccent2),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.kAccent2.withOpacity(0.2),
                        child:
                            const Icon(Icons.check, color: AppColors.kAccent2),
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
                              checkOutTime,
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
          RichText(
            text: TextSpan(
              text: DateTime.now().day.toString(),
              style: AppTypography.kBold16.copyWith(color: AppColors.kAccent1),
              children: [
                TextSpan(
                  text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                  style: AppTypography.kLight14.copyWith(
                    color: isDarkMode ? AppColors.kWhite : AppColors.kGrey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Location: $currentAddress',
            style: AppTypography.kMedium14.copyWith(color: AppColors.kGrey),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
