import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/constrants/constants.dart';
import '../model/data_model.dart';

class ActivityCard extends StatelessWidget {
  final ActivityData activity;

  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    double percentage =
        (activity.achievedActivityNumbers / activity.targetActivityNumbers) *
            100;
    return PrimaryContainer(
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.h),
                child: Container(
                  color: activity.achievedActivityColor.withOpacity(0.1),
                  height: 40.h,
                  width: 40.h,
                  child: Icon(
                    activity.icon,
                    size: 20.h,
                    color: activity.achievedActivityColor,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Today: ',
                  style: AppTypography.kMedium12.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kGrey,
                  ),
                  children: [
                    TextSpan(
                      text: '\n${activity.todayActivity}',
                      style: AppTypography.kMedium12.copyWith(
                        color: activity.todayActivityColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(activity.activityName,
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              style: AppTypography.kMedium14
              // style: const TextStyle(
              //   color: Colors.white,
              //   fontSize: 16,
              //   fontWeight: FontWeight.bold,
              // ),
              ),
          ProgressLine(
            color: activity.achievedActivityColor,
            percentage: percentage.toInt(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Achieved: ',
                  style: AppTypography.kMedium12.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kGrey,
                  ),
                  children: [
                    TextSpan(
                      text: '\n${activity.achievedActivityNumbers}',
                      style: AppTypography.kMedium12.copyWith(
                        color: activity.achievedActivityColor,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Target: ',
                  style: AppTypography.kMedium12.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kGrey,
                  ),
                  children: [
                    TextSpan(
                      text: '\n${activity.targetActivityNumbers}',
                      style: AppTypography.kMedium12.copyWith(
                        color: activity.targetActivityColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    super.key,
    this.color = Colors.blue,
    required this.percentage,
  });

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
