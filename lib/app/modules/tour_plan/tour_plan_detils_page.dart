import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../data/constrants/constants.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'components/tour_list_view.dart';
import 'model/tour_list_model.dart';
import 'tour_plan_edit_page.dart';

class TourPlanDetailsPage extends StatelessWidget {
  final TourPlan tourPlan;

  const TourPlanDetailsPage({super.key, required this.tourPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Tour Details',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
        centerTitle: true,
        action: [
          CustomButton(
            icon: Icons.edit,
            text: 'Edit Tour',
            isBorder: true,
            onTap: () async {
              await Get.to(
                () => TourPlanEditPage(
                  tourPlan: tourPlan,
                ),
              );
              Get.back();
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            TourPlanListCard(
              tourPlan: tourPlan,
            ),
            SizedBox(height: 16.h),

            // Section Title: Tour Details
            CustomHeaderText(
              text: 'Tour Details',
              fontSize: 18.sp,
            ),
            SizedBox(height: 12.h),

            BuildInfoCard(
              title: 'Tour Date:',
              content: formatDate(tourPlan.tourDate),
            ),
            SizedBox(height: 16.h),

            // Village Details
            _buildListSection(
              title: 'Villages Covered:',
              items: tourPlan.villageNames,
            ),

            SizedBox(height: 16.h),

            // Route Details
            _buildListSection(
              title: 'Routes:',
              items: tourPlan.routeNames,
            ),

            SizedBox(height: 16.h),

            // Activity Details
            _buildListSection(
              title: 'Activities:',
              items: tourPlan.activityNames,
            ),

            SizedBox(height: 16.h),

            // Remarks Section
            if (tourPlan.remarks.isNotEmpty)
              BuildInfoCard(title: 'Remarks', content: tourPlan.remarks),
          ],
        ),
      ),
    );
  }

  // Helper: Format the Date
  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yyyy').format(date);
    } catch (_) {
      return dateStr; // Return as-is if parsing fails
    }
  }

  /// Builds a section for displaying lists of strings
  Widget _buildListSection(
      {required String title, required List<String> items}) {
    return PrimaryContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                AppTypography.kBold14.copyWith(color: AppColors.kDarkContiner),
          ),
          SizedBox(height: 8.h),
          ...items.map((item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_right,
                      size: 16.sp,
                      color: AppColors.kPrimary,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        item,
                        style: AppTypography.kBold12.copyWith(
                          color: AppColors.kDarkContiner,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class BuildInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const BuildInfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: EdgeInsets.all(12.h),
      width: double.infinity, // Full width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                AppTypography.kBold14.copyWith(color: AppColors.kDarkContiner),
          ),
          SizedBox(height: 5.h),
          Text(
            content,
            style: AppTypography.kBold12.copyWith(
              color: AppColors.kDarkContiner,
            ),
          ),
        ],
      ),
    );
  }
}
