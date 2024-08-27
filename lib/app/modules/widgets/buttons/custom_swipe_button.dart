import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../data/constrants/constants.dart';

class CustomSwipeButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSwipe;
  const CustomSwipeButton({
    required this.title,
    required this.subtitle,
    required this.onSwipe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return SwipeButton.expand(
      borderRadius: BorderRadius.circular(8),
      width: double.maxFinite,
      activeThumbColor:
          isDarkMode(context) ? AppColors.kSecondary : AppColors.kPrimary,
      activeTrackColor:
          isDarkMode(context) ? AppColors.kDarkHint : const Color(0xFFEAF6EF),
      thumb: Icon(
        AppAssets.kArrowForwardRounded,
        color: isDarkMode(context) ? AppColors.kBackground : AppColors.kWhite,
      ),
      onSwipe: onSwipe,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: AppTypography.kBold16.copyWith(
                  color:
                      isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
                ),
              ),
              TextSpan(
                text: '\n$subtitle',
                style: AppTypography.kLight12.copyWith(
                  color:
                      isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
