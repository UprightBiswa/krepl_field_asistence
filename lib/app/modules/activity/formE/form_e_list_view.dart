// form_e_list_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/action_menue.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/dialog/confirmation.dart';
import '../controller/form_e_controller.dart';
import '../model/form_e_model.dart';
import 'form_e_details_page.dart';

class FormEListView extends StatelessWidget {
  final PagingController<int, FormE> pagingController;

  const FormEListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagingListener<int, FormE>(
        controller: pagingController,
        builder: (context, state, fetchNextPage) {
          return PagedListView<int, FormE>(
            state: state,
            fetchNextPage: fetchNextPage,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<FormE>(
              itemBuilder: (context, formE, index) => GestureDetector(
                onTap: () => Get.to(() => FormEDetailPage(formE: formE)),
                child: FormECard(formE: formE),
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

class FormECard extends StatelessWidget {
  final FormE formE;

  FormECard({super.key, required this.formE});
  final FormEController formEController = Get.find<FormEController>();

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
                      formE.promotionActivityType,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Employee Code
                    Text(
                      'Party Type: ${formE.partyType}',
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
                  _showConfirmationDialog(context, formE.id);
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
                ' ${formE.totalPartyNo}',
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
                    'Total POP Material:',
                    style: AppTypography.kMedium14,
                  ),
                ],
              ),
              Text(
                ' ${formE.publicityDetails.length}',
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
                formatDate(formE.activityPerformedDate),
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
                formatDate(formE.createdAt),
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

  void _showConfirmationDialog(BuildContext context, int formEId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Confirm Delete',
          content: 'Are you sure you want to delete this?',
          onConfirm: () async {
            Get.back();
            // Show loading dialog
            if (formEController.isDeleteLoading.value) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }
            await formEController.deleteFormE(formEId);
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
