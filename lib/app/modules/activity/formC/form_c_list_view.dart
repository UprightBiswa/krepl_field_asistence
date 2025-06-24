import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../home/components/action_menue.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/dialog/confirmation.dart';
import '../controller/form_c_controller.dart';
import '../model/form_c_model.dart';
import 'form_c_details_page.dart';
import '../../../data/constrants/constants.dart';

class FormCListView extends StatelessWidget {
  final PagingController<int, FormC> pagingController;

  const FormCListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagingListener<int, FormC>(
        controller: pagingController,
        builder: (context, state, fetchNextPage) {
          return PagedListView<int, FormC>(
            state: state,
            fetchNextPage: fetchNextPage,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<FormC>(
              itemBuilder: (context, formC, index) => GestureDetector(
                  onTap: () => Get.to(() => FormCDetailPage(formC: formC)),
                  child: FormCCard(formC: formC)),
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

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

class FormCCard extends StatelessWidget {
  final FormC formC;

  FormCCard({super.key, required this.formC});
  final FormCController formCController = Get.find<FormCController>();

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
                      formC.promotionActivityType,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Employee Code
                    Text(
                      'Party Type: ${formC.partyType}',
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
                  _showConfirmationDialog(context, formC.id);
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
                formatDate(formC.activityPerformedDate),
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
                formatDate(formC.createdAt),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          FormCSummary(
            totalQuantity: formC.quantity,
            totalExpense: formC.expense,
            totalProduct: totalProduct(formC.productDetails),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, int formCId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Confirm Delete',
          content: 'Are you sure you want to delete this?',
          onConfirm: () async {
            Get.back();
            if (formCController.isDeleteLoading.value) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }
            await formCController.deleteFormC(formCId);
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

  String totalProduct(List<String> formCDetails) {
    int total = formCDetails.length;

    return total.toString();
  }
}

class FormCSummary extends StatelessWidget {
  final String totalQuantity;
  final String totalExpense;
  final String totalProduct;

  const FormCSummary({
    super.key,
    required this.totalQuantity,
    required this.totalExpense,
    required this.totalProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: isDarkMode(context) ? AppColors.kDarkContiner : AppColors.kWhite,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryColumn(
            icon: Icons.inventory,
            title: 'Total Quantity',
            value: totalQuantity,
          ),
          _VerticalDivider(),
          _SummaryColumn(
            icon: Icons.currency_rupee_sharp,
            title: 'Total Value', //add rupee symbol
            value: '₹$totalExpense',
          ),
          _VerticalDivider(),
          _SummaryColumn(
            icon: Icons.production_quantity_limits,
            title: 'Total Product',
            value: totalProduct,
          ),
        ],
      ),
    );
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
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
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
