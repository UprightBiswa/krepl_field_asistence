import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../widgets/containers/primary_container.dart';
import '../model/form_c_model.dart';
import 'form_c_details_page.dart';

class FormCListView extends StatelessWidget {
  final PagingController<int, FormC> pagingController;

  const FormCListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FormC>(
      pagingController: pagingController,
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
  }
}

class FormCCard extends StatelessWidget {
  final FormC formC;

  const FormCCard({super.key, required this.formC});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.campaign, color: Colors.blueAccent, size: 20.sp),
              Expanded(
                child: Text(
                  formC.promotionActivityType,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.perm_identity, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Party Type: ${formC.partyType}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Date: ${formC.createdAt}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          SizedBox(height: 10.h),
          FormCSummary(
            totalQuantity: totalQuantity(formC.formCDetails),
            totalExpense: totalExpense(formC.formCDetails).toDouble(),
            totalProduct: totalProduct(formC.formCDetails),
          ),
        ],
      ),
    );
  }

  int totalQuantity(List<FormCDetail> formCDetails) {
    int total = 0;
    for (var i = 0; i < formCDetails.length; i++) {
      total += int.parse(formCDetails[i].quantity);
    }
    return total;
  }

  int totalExpense(List<FormCDetail> formCDetails) {
    int total = 0;
    for (var i = 0; i < formCDetails.length; i++) {
      total += int.parse(formCDetails[i].expense);
    }
    return total;
  }

  int totalProduct(List<FormCDetail> formCDetails) {
    int total = formCDetails.length;

    return total;
  }
}

class FormCSummary extends StatelessWidget {
  final int totalQuantity;
  final double totalExpense;
  final int totalProduct;

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryColumn(
            icon: Icons.inventory,
            title: 'Total Quantity',
            value: '$totalQuantity',
          ),
          _VerticalDivider(),
          _SummaryColumn(
            icon: Icons.currency_rupee_sharp,
            title: 'Total Expense', //add rupee symbol
            value: '₹${totalExpense.toStringAsFixed(2)}',
          ),
          _VerticalDivider(),
          _SummaryColumn(
            icon: Icons.production_quantity_limits,
            title: 'Total Product',
            value: '$totalProduct',
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
        Icon(icon, size: 24.sp, color: Colors.blue),
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