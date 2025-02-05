import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/buttons/buttons.dart';

class CustomMenuCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;
  final IconData icon;

  const CustomMenuCard({
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return AnimatedButton(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? (isDarkMode(context) ? Colors.black : AppColors.kWhite)
                  : (isDarkMode(context)
                      ? Colors.black.withOpacity(0.15)
                      : AppColors.kPrimary.withOpacity(0.15)),
              boxShadow: isSelected ? [AppColors.defaultShadow] : null,
            ),
            child: Icon(
              icon,
              color: AppColors.kPrimary,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: AppTypography.kLight10,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
