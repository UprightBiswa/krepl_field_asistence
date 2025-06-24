import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/action_menue.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/dialog/confirmation.dart';
import '../controller/form_d_controller.dart';
import '../model/form_d_model.dart';
import 'form_d_details_page.dart';

class FormDListView extends StatelessWidget {
  final PagingController<int, FormD> pagingController;

  const FormDListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagingListener<int, FormD>(
        controller: pagingController,
        builder: (context, state, fetchNextPage) {
          return PagedListView<int, FormD>(
            state: state,
            fetchNextPage: fetchNextPage,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<FormD>(
              itemBuilder: (context, formD, index) => GestureDetector(
                onTap: () => Get.to(() => FormDDetailPage(formD: formD)),
                child: FormDCard(formD: formD),
              ),
              firstPageErrorIndicatorBuilder: (context) =>
                  const Center(child: Text('Failed to load data')),
              noItemsFoundIndicatorBuilder: (context) =>
                  const Center(child: Text('No data available')),
              newPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}

class FormDCard extends StatelessWidget {
  final FormD formD;

  FormDCard({super.key, required this.formD});
  final FormDController formDController = Get.find<FormDController>();

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
                backgroundColor: AppColors.kPrimary.withValues(alpha: 0.15),
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
                      formD.promotionActivityType,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Employee Code
                    Text(
                      'Party Type: ${formD.partyType}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              ActionMenuIcon(
                onDelete: () {
                  _showConfirmationDialog(context, formD.id);
                },
              ),
            ],
          ),
          // Divider
          Divider(
            color: Colors.grey.withValues(alpha: 0.5),
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
                ' ${formD.totalPartyNo}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          //total demo details show the
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.domain_verification_outlined,
                    size: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Total Demo products:',
                    style: AppTypography.kMedium14,
                  ),
                ],
              ),
              Text(
                ' ${formD.productDetails.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          //show next demo date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Activity Performed Date:',
                    style: AppTypography.kMedium14,
                  ),
                ],
              ),
              Text(
                formatDate(formD.activityPerformedDate),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          //show next demo date
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
                    'Next Demo Date:',
                    style: AppTypography.kMedium14,
                  ),
                ],
              ),
              Text(
                formatDate(formD.nextDemoDate),
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
                    Icons.calendar_month_outlined,
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
                formatDate(formD.createdAt),
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

  void _showConfirmationDialog(BuildContext context, int formDId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Confirm Delete',
          content: 'Are you sure you want to delete this?',
          onConfirm: () async {
            Get.back();
            // Show loading dialog
            if (formDController.isDeleteLoading.value) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }
            await formDController.deleteFormD(formDId);
          },
          onCancel: () {
            Get.back();
          },
        );
      },
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
