import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../widgets/components/Info_row_widget.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'components/tour_list_view.dart';
import 'model/tour_list_model.dart';

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
        iconColor: AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Tour Details',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
        centerTitle: true,
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

            // Village Details
            _buildListSection(
              title: 'Villages Covered:',
              items: tourPlan.village,
            ),

            SizedBox(height: 16.h),

            // Route Details
            _buildListSection(
              title: 'Routes:',
              items: tourPlan.route,
            ),

            SizedBox(height: 16.h),

            // Activity Details
            _buildListSection(
              title: 'Activities:',
              items: tourPlan.activity,
            ),

            SizedBox(height: 16.h),

            // Remarks Section
            if (tourPlan.remarks.isNotEmpty)
              PrimaryContainer(
                child: InfoRow(
                  label: 'Remarks:',
                  value: tourPlan.remarks,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds a section for displaying lists of strings
  Widget _buildListSection({required String title, required List<String> items}) {
    return PrimaryContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.kBold14.copyWith(color: AppColors.kDarkContiner),
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
