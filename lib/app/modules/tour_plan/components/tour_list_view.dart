import 'package:field_asistence/app/data/constrants/app_colors.dart';
import 'package:field_asistence/app/data/constrants/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/containers/primary_container.dart';
import '../controller/tour_plan_lsit_controller.dart';
import '../tour_plan_detils_page.dart';
import '../model/tour_list_model.dart';

class TourPlanListView extends StatelessWidget {
  final TourPlanController controller = Get.find();

  TourPlanListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isError.value) {
        return Center(child: Text(controller.errorMessage.value));
      }

      if (controller.isLoading.value && controller.tourPlanList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.tourPlanList.length +
            (controller.isLoadingMore.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.tourPlanList.length) {
            final tourPlan = controller.tourPlanList[index];
            return GestureDetector(
              onTap: () async {
                await Get.to(() => TourPlanDetailsPage(tourPlan: tourPlan));
                controller.fetchTourPlans(refresh: true);
              },
              child: TourPlanListCard(tourPlan: tourPlan),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    });
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
            children: [
              // Circle Avatar for initials
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.kPrimary.withValues(alpha: .15),
                child: Text(
                  tourPlan.employeename.substring(0, 2).toUpperCase(),
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
                      tourPlan.employeename.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Employee Code
                    Text(
                      'Code: ${tourPlan.hremployeecode.toString()}',
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
            color: Colors.grey.withValues(alpha: .5),
            thickness: 1.h,
            height: 25.h,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Created Date:',
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Created Date

                _SummaryColumn(
                  icon: Icons.holiday_village,
                  title: 'Total Village',
                  value: '${tourPlan.villageNames.length}',
                ),

                _VerticalDivider(),
                _SummaryColumn(
                  icon: Icons.tour,
                  title: 'Total Route',
                  value: '${tourPlan.routeNames.length}',
                ),

                _VerticalDivider(),
                _SummaryColumn(
                  icon: Icons.local_activity,
                  title: 'Total Activity',
                  value: '${tourPlan.activityNames.length}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getStatusText(int status) {
    switch (status) {
      case 0:
        return "Pending";
      case 1:
        return "Approved";
      case 2:
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return AppColors.kWarning;
      case 1:
        return Colors.green;
      case 2:
        return AppColors.kAccent7;
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

class _SummaryColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SummaryColumn({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24.sp, color: Colors.teal),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 1.w,
      color: Colors.grey.shade300,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }
}
