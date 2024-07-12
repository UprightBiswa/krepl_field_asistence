
import 'package:field_asistence/app/modules/home/components/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/home/course.dart';
import '../../widgets/widgets.dart';

class CourseList extends StatelessWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Trending Courses', style: AppTypography.kBold14),
            const Spacer(),
            CustomTextButton(
              onPressed: () {},
              text: 'See All',
              color: AppColors.kSecondary.withOpacity(0.3),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.twentyVertical),
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return CourseCard(
                course: coursesList[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 30.w),
            itemCount: coursesList.length,
          ),
        ),
      ],
    );
  }
}
