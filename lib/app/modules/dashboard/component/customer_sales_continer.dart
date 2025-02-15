import 'package:field_asistence/app/modules/widgets/buttons/custom_button.dart';
import 'package:field_asistence/app/modules/widgets/texts/custom_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/login/user_details_reponse.dart';
import '../../widgets/loading/shimmer_activity_card.dart';
import '../controllers/activity_controller.dart';
import '../customer_sales_view_page.dart';
import '../model/cutomer _sales_data.dart';

class CustomerSalesContainer extends StatefulWidget {
  final UserDetails userDetails;
  final bool isYtd;

  const CustomerSalesContainer({
    super.key,
    required this.userDetails,
    required this.isYtd,
  });

  @override
  State<CustomerSalesContainer> createState() => _CustomerSalesContainerState();
}

class _CustomerSalesContainerState extends State<CustomerSalesContainer> {
  final ActivityController controller = Get.put(ActivityController());
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomHeaderText(
              text: 'Customer Sales',
              fontSize: 18.sp,
            ),
            const Spacer(),
            CustomButton(
              text: 'See All',
              onTap: () {
                Get.to(() => CustomerSalesPage());
              },
              icon: Icons.arrow_forward_ios,
              iconSize: 16.h,
              isBorder: true,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomerSalesListView(controller: controller, isYtd: widget.isYtd),
      ],
    );
  }
}

class CustomerSalesListView extends StatelessWidget {
  final ActivityController controller;
  final bool isYtd;

  const CustomerSalesListView({
    super.key,
    required this.controller,
    required this.isYtd,
  });
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isYtd
          ? controller.isLoadingYtdSales.value
          : controller.isLoadingMtdSales.value) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10, // Number of shimmer placeholders
          itemBuilder: (context, index) => const ShimmerActivityCard(),
        );
      } else if (isYtd
          ? controller.isErrorYtdSales.value
          : controller.isErrorMtdSales.value) {
        return const Center(child: Text('Error loading sales data'));
      } else if ((isYtd ? controller.ytdSalesData : controller.mtdSalesData)
          .isEmpty) {
        return const Center(child: Text('No sales data available'));
      } else {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: isYtd
              ? controller.ytdSalesData.length
              : controller.mtdSalesData.length,
          separatorBuilder: (context, index) => SizedBox(
            height: 10.h,
          ),
          itemBuilder: (context, index) {
            final salesData = isYtd
                ? controller.ytdSalesData[index]
                : controller.mtdSalesData[index];
            return CustomerSalesCard(
              salesData: salesData,
              isYtd: isYtd,
            );
          },
        );
      }
    });
  }
}

class CustomerSalesCard extends StatelessWidget {
  final SalesData salesData;
  final bool isYtd;

  const CustomerSalesCard({
    super.key,
    required this.salesData,
    required this.isYtd,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isDark ? Colors.grey[800] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey[300]!,
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer Info
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.blueAccent.withAlpha(50),
                child: Text(
                  salesData.customerName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      salesData.customerName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      'Customer No: ${salesData.customerNo}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              // Total Comparison Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withAlpha(50),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  isYtd ? 'YTD' : 'MTD',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),
          // Comparison Chart (Bar Chart Representation)
          Row(
            children: [
              // Current Total Section
              Expanded(
                child: Column(
                  children: [
                    Text(
                      isYtd ? 'Current Year' : 'Current Month',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                    Text(
                      '\u{20B9}${isYtd ? salesData.currentYearTotal.toStringAsFixed(2) : salesData.currentMonthTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 10.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.greenAccent.withAlpha(100),
                            Colors.green,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              // Previous Total Section
              Expanded(
                child: Column(
                  children: [
                    Text(
                      isYtd ? 'Last Year' : 'Last Month',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                    Text(
                      '\u{20B9}${isYtd ? salesData.previousYearTotal.toStringAsFixed(2) : salesData.previousMonthTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 10.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.redAccent.withAlpha(100),
                            Colors.red,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
