import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../widgets.dart';

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback leadingCallback;
  final Color? iconColor;
  final Widget? title;
  final List<Widget>? action;
  final bool centerTitle;
  const CustomBackAppBar({
    required this.leadingCallback,
    this.iconColor,
    this.title,
    this.action,
    this.centerTitle = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 70.w,
      systemOverlayStyle: customOverlay,
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
