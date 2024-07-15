import 'package:field_asistence/app/data/constrants/app_colors.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.kPrimary,
            AppColors.kPrimary.withOpacity(0.2),
            // End color
          ],
        ),
      ),
      child: child,
    );
  }
}
