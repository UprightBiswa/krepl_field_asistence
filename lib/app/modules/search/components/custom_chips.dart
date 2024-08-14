import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

import '../../../data/constrants/constants.dart';
import '../../home/model/menu_group.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/containers/primary_container.dart';

class CustomChips extends StatelessWidget {
  final MenuItem menuItem;
  final int index;
  final VoidCallback onTap;
  final bool isSelected;
  const CustomChips({
    required this.isSelected,
    required this.menuItem,
    required this.index,
    required this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return FadeIn(
      delay: const Duration(milliseconds: 200) * index,
      child: AnimatedButton(
        onTap: onTap,
        child: PrimaryContainer(
          color: isSelected
              ? AppColors.kPrimary
              : isDarkMode(context)
                  ? Colors.black
                  : AppColors.kWhite,
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                menuItem.icon,
                color: colorGenerator.generateColor(),
              ),
              SizedBox(
                width: index == 0
                    ? 37.w
                    : index == 2
                        ? 20.w
                        : 27.w,
              ),
              Text(
                menuItem.title,
                style: AppTypography.kBold14.copyWith(
                  color: isSelected
                      ? AppColors.kWhite
                      : isDarkMode(context)
                          ? Colors.white
                          : AppColors.kDarkContiner,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
