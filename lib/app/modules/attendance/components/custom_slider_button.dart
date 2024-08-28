import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../data/constrants/constants.dart';

class CustomSliderButton extends StatelessWidget {
  final String label;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onSlideComplete;

  const CustomSliderButton({
    super.key,
    required this.label,
    required this.activeColor,
    required this.inactiveColor,
    required this.onSlideComplete,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return SwipeButton.expand(
      borderRadius:
          BorderRadius.circular(25), // Matching the previous border radius
      width: double.maxFinite,
      activeThumbColor: activeColor,
      activeTrackColor: inactiveColor,
      thumb: Icon(
        Icons.arrow_forward, // Customize the icon here
        color: isDarkMode(context) ? AppColors.kBackground : AppColors.kWhite,
      ),
      onSwipe: onSlideComplete,
      child: Center(
        child: Text(
          label,
          style: AppTypography.kBold16.copyWith(
            color: isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
          ),
        ),
      ),
    );
  }
}
