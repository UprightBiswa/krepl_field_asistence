import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/home/best_dealers_model.dart';
import '../../profile/components/profile_image_card.dart';
import '../../widgets/containers/primary_container.dart';

class BestTeachersCard extends StatelessWidget {
  final PageController pageController;
  final int index;
  final BestTeachersModel teacher;
  const BestTeachersCard({
    required this.index,
    required this.pageController,
    required this.teacher,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        var value = 0.0;
        if (pageController.position.haveDimensions) {
          value = index.toDouble() - (pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              PrimaryContainer(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 15.0.w, right: 15.w, top: 30.h),
                padding: EdgeInsets.only(
                  top: 50.h,
                  bottom: AppSpacing.thirtyVertical,
                ),
                child: Column(
                  children: [
                    Text(teacher.name, style: AppTypography.kBold16),
                    Text(teacher.bio, style: AppTypography.kLight14),
                    const Spacer(),
                    const Icon(AppAssets.kCrown),
                    SizedBox(height: 5.h),
                    Container(
                      height: 40.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: teacher.position == 1
                            ? AppColors.kAccent1
                            : teacher.position == 2
                                ? AppColors.kAccent2
                                : AppColors.kPrimary,
                      ),
                      child: Text(
                        '${teacher.position}',
                        style: AppTypography.kBold14
                            .copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  ],
                ),
              ),
              ProfileImageCard(
                size: 60.h,
                image: teacher.image,
              ),
            ],
          ),
        );
      },
    );
  }
}
