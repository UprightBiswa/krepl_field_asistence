import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/form_b_model.dart';
import 'form_b_details_page.dart';

class FormBListView extends StatelessWidget {
  final PagingController<int, FormB> pagingController;

  const FormBListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FormB>(
      pagingController: pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<FormB>(
        itemBuilder: (context, formB, index) => GestureDetector(
            onTap: () => Get.to(() => FormBDetailPage(formB: formB)),
            child: FormBCard(formB: formB)),
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

class FormBCard extends StatelessWidget {
  final FormB formB;

  const FormBCard({super.key, required this.formB});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Circle Avatar for initials
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.kPrimary.withOpacity(0.15),
                child: const Icon(
                  Icons.campaign,
                  color: AppColors.kPrimary,
                ),
              ),
              SizedBox(width: 16.w),
              // Expense Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employee Name
                    Text(
                      formB.promotionActivityType,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Employee Code
                    Text(
                      'Party Type: ${formB.partyType}',
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.groups,
                    size: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Total Parties:',
                    style: AppTypography.kMedium14,
                  ),
                ],
              ),
              Text(
                ' ${formB.totalPartyNo}',
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
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Created Date:',
                    style: AppTypography.kMedium14,
                  ),
                ],
              ),
              Text(
                formatDate(formB.createdAt),
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
