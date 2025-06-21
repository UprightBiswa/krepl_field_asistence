import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../widgets/components/info_row_widget.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'components/expense_list_view.dart';
import 'model/expense_list_model.dart';

class ExpenseDetailsPage extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsPage({super.key, required this.expense});

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
          'Expense Details',
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
            // Expense Header Card
            ExpenseListCard(
              expense: expense,
            ),
            SizedBox(height: 16.h),
            // Details Section
            CustomHeaderText(
              text: 'Expense Details',
              fontSize: 18.sp,
            ),
            SizedBox(height: 12.h),
            // Expense Details List
            _buildDetailsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expense.details.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 16.h,
      ),
      itemBuilder: (context, index) {
        final detail = expense.details[index];
        return PrimaryContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expense Type
              InfoRow(
                label: 'Expense Type:',
                value: detail.expenseType,
              ),
              InfoRow(
                label: 'Month:',
                value: detail.month,
              ),
              InfoRow(
                label: 'Financial Year:',
                value: detail.financialYear,
              ),

              InfoRow(
                label: 'Amount:',
                value: '₹${detail.amount}',
              ),
            ],
          ),
        );
      },
    );
  }
}
