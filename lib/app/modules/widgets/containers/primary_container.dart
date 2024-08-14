import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? width;
  final double? height;
  final double? radius;

  const PrimaryContainer({
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.h),
      margin: margin,
      decoration: BoxDecoration(
        color: color ??
            (isDarkMode(context)
                ? AppColors.kDarkSurfaceColor
                : AppColors.kWhite),
        boxShadow: [
          if (isDarkMode(context))
            AppColors.darkShadow
          else
            AppColors.defaultShadow,
        ],
        borderRadius: BorderRadius.circular(radius ?? 10.r),
      ),
      child: child,
    );
  }
}
