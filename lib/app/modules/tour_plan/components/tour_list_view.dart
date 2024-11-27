import 'package:field_asistence/app/data/constrants/app_colors.dart';
import 'package:field_asistence/app/data/constrants/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../widgets/containers/primary_container.dart';
import '../tour_plan_detils_page.dart';
import '../model/tour_list_model.dart';

class TourPlanListView extends StatelessWidget {
  final PagingController<int, TourPlan> pagingController;

  const TourPlanListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, TourPlan>(
      pagingController: pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<TourPlan>(
        itemBuilder: (context, tourPlan, index) => GestureDetector(
          onTap: () {
            Get.to(() => TourPlanDetailsPage(tourPlan: tourPlan));
          },
          child: TourPlanListCard(tourPlan: tourPlan),
        ),
        firstPageErrorIndicatorBuilder: (context) =>
            const Center(child: Text('Failed to load data')),
        noItemsFoundIndicatorBuilder: (context) =>
            const Center(child: Text('No data available')),
        newPageProgressIndicatorBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class TourPlanListCard extends StatelessWidget {
  final TourPlan tourPlan;

  const TourPlanListCard({super.key, required this.tourPlan});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circle Avatar for initials
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.kPrimary.withOpacity(0.15),
                child: Text(
                  tourPlan.tourDate.substring(0, 2).toUpperCase(),
                  style: TextStyle(
                    color: AppColors.kPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // tourPlan Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employee Name
                    Text(
                      tourPlan.id.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Employee Code
                    Text(
                      'Code: ${tourPlan.id.toString()}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Divider
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 1.h,
            height: 25.h,
          ),
          // Status and Total Count

          // Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //show text ststus
              Text(
                'Status:',
                style: AppTypography.kMedium14,
              ),
              Text(
                getStatusText(tourPlan.status),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: getStatusColor(tourPlan.status),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Created Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Created At:',
                style: AppTypography.kMedium14,
              ),
              Text(
                formatDate(tourPlan.createdAt),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Village:',
                style: AppTypography.kMedium14,
              ),
              Text(
                ' ${tourPlan.village.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Route:',
                style: AppTypography.kMedium14,
              ),
              Text(
                ' ${tourPlan.route.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Activity:',
                style: AppTypography.kMedium14,
              ),
              Text(
                ' ${tourPlan.activity.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  String getStatusText(int status) {
    switch (status) {
      case 1:
        return "Pending";
      case 2:
        return "Approved";
      case 3:
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.black;
    }
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
}
