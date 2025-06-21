import 'package:field_asistence/app/data/constrants/app_colors.dart';
import 'package:field_asistence/app/data/constrants/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../widgets/containers/primary_container.dart';
import '../expense_detils_page.dart';
import '../model/expense_list_model.dart';

class ExpenseListView extends StatelessWidget {
  final PagingController<int, Expense> pagingController;

  const ExpenseListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagingListener<int, Expense>(
        controller: pagingController,
        builder: (context, state, fetchNextPage) {
          return PagedListView<int, Expense>(
            state: state,
            fetchNextPage: fetchNextPage,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<Expense>(
              itemBuilder: (context, expense, index) => GestureDetector(
                onTap: () {
                  Get.to(() => ExpenseDetailsPage(expense: expense));
                },
                child: ExpenseListCard(expense: expense),
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

class ExpenseListCard extends StatelessWidget {
  final Expense expense;

  const ExpenseListCard({super.key, required this.expense});

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
                backgroundColor: AppColors.kPrimary.withValues(alpha: 0.15),
                child: Text(
                  expense.employeeName.substring(0, 2).toUpperCase(),
                  style: TextStyle(
                    color: AppColors.kPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
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
                      expense.employeeName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Employee Code
                    Text(
                      'Code: ${expense.employeeCode}',
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
            color: Colors.grey.withValues(alpha: 0.5),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: getStatusColor(expense.status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  getStatusText(expense.status),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(expense.status),
                  ),
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
                formatDate(expense.createdAt),
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
                'Total Expense:',
                style: AppTypography.kMedium14,
              ),
              Text(
                ' ${expense.details.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          if (expense.details.isNotEmpty) SizedBox(height: 8.h),
          if (expense.details.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount:',
                  style: AppTypography.kMedium14,
                ),
                Text(
                  '₹${calculateTotalAmount(expense.details)}',
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
    print('${status}');
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

  // Helper: Calculate Total Amount
  String calculateTotalAmount(List<ExpenseDetail> details) {
    double total = details.fold(
        0, (sum, detail) => sum + (double.tryParse(detail.amount) ?? 0.0));
    return total.toStringAsFixed(2); // Return as string with 2 decimals
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
