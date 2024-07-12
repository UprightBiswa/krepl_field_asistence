import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/dividers/custom_vertical_divider.dart';


class DataRowWidget extends StatelessWidget {
  final String title;
  final String current;
  final String target;
  final String ly;

  const DataRowWidget({
    Key? key,
    required this.title,
    required this.current,
    required this.target,
    required this.ly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomVerticalDivider(
              color: AppColors.kSecondary,
              height: 20.h,
              width: 4.w,
            ),
            SizedBox(width: 5.w),
            Text(
              title,
              style: AppTypography.kMedium16.copyWith(
                color: isDarkMode(context) ? AppColors.kHint : AppColors.kGrey,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              current,
              style: AppTypography.kLight12.copyWith(
                color: isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
              ),
            ),
            Text(
              target,
              style: AppTypography.kLight12.copyWith(
                color: isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
              ),
            ),
            Text(
              ly,
              style: AppTypography.kLight12.copyWith(
                color: isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
