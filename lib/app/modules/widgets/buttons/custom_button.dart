import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isBorder;
  final double? iconSize;
  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.isBorder = false,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return AnimatedButton(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: isDarkMode(context)
                ? AppColors.kContentColor
                : AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppSpacing.radiusThirty),
            border: isBorder ? Border.all(color: AppColors.kHint) : null),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: AppTypography.kLight12.copyWith(
                  color: isDarkMode(context)
                      ? AppColors.kWhite
                      : AppColors.kPrimary),
            ),
            SizedBox(width: 5.w),
            Icon(
              icon,
              size: iconSize ?? 20.w,
              color:
                  isDarkMode(context) ? AppColors.kWhite : AppColors.kPrimary,
            )
          ],
        ),
      ),
    );
  }
}
