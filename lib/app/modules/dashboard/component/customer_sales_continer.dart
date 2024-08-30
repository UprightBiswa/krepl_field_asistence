import 'package:field_asistence/app/data/constrants/app_typography.dart';
import 'package:field_asistence/app/modules/widgets/buttons/custom_button.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:field_asistence/app/modules/widgets/texts/custom_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/login/user_details_reponse.dart';
import '../../widgets/loading/shimmer_activity_card.dart';
import '../controllers/activity_controller.dart';

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
    return PrimaryContainer(
      child: Column(
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
                text: 'View All',
                onTap: () {},
                icon: Icons.arrow_forward_ios,
                iconSize: 16.h,
                isBorder: true,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomerSalesListView(controller: controller, isYtd: widget.isYtd),
        ],
      ),
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
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final salesData = isYtd
                ? controller.ytdSalesData[index]
                : controller.mtdSalesData[index];
            return ListTile(
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              trailing: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Text(salesData.customerName[0]),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    salesData.customerName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTypography.kMedium14,
                  ),
                  Text('Cus No: ${salesData.customerNo}',
                      style: AppTypography.kMedium10),
                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Curt Year:', style: AppTypography.kLight12),
                        Text('\u{20B9}${salesData.currentYearData},',
                            style: AppTypography.kBold12),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last Year:', style: AppTypography.kLight12),
                        Text('\u{20B9}${salesData.previousYearData}',
                            style: AppTypography.kBold12),
                      ],
                    ),
                  ),
                ],
              ),

              onTap: () {
                // Handle item tap, maybe navigate to a details page
              },
            );
          },
        );
      }
    });
  }
}