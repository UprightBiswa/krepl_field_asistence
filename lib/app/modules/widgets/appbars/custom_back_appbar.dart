import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../attendance/attendance_view_page.dart';
import '../widgets.dart';

class GradientUtil {
  // Define a method that returns a gradient for app bars or any widget
  static LinearGradient appBarGradient({
    required Color startColor,
    required Color endColor,
  }) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        startColor,
        endColor,
      ],
    );
  }
}

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback leadingCallback;
  final Color? iconColor;
  final Widget? title;
  final List<Widget>? action;
  final bool centerTitle;
  final bool? spaceBar;
  const CustomBackAppBar({
    required this.leadingCallback,
    this.iconColor,
    this.title,
    this.action,
    this.centerTitle = true,
    this.spaceBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 70.w,
      systemOverlayStyle: customOverlay,
      flexibleSpace: spaceBar != null
          ? Container(
              decoration: BoxDecoration(
                gradient: GradientUtil.appBarGradient(
                  startColor: AppColors.kPrimary,
                  endColor: AppColors.kPrimary.withOpacity(0.2),
                ),
              ),
            )
          : null,
      leading: Padding(
        padding: EdgeInsets.all(7.h),
        child: CustomIconButton(
          onTap: leadingCallback,
          icon: AppAssets.kArrowBack,
          color: iconColor,
        ),
      ),
      centerTitle: centerTitle,
      title: title,
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
