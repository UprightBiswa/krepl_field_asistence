import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/components/Info_row_widget.dart';
import '../../widgets/containers/primary_container.dart';
import '../controller/retailer_controller.dart';
import '../retailer_details_view.dart';
import '../model/retailer_model_list.dart';

class RetailerListCard extends StatelessWidget {
  final Retailer retailer;
  final int index;

  const RetailerListCard({
    required this.retailer,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RetailerController retailerController =
        Get.find<RetailerController>();

    return FadeIn(
      delay: const Duration(milliseconds: 500) * index,
      child: AnimatedButton(
        onTap: () {
          Get.to<dynamic>(
            () => RetailerDetailView(
              retailer: retailer,
            ),
            transition: Transition.rightToLeftWithFade,
          )!
              .then((value) {
            retailerController.refreshItems();
          });
        },
        child: PrimaryContainer(
          padding: EdgeInsets.all(10.h),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.kPrimary.withOpacity(0.15),
                    child: Text(
                      retailer.retailerName.substring(0, 2).toUpperCase(),
                      style: AppTypography.kBold14.copyWith(
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // doctor details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          retailer.retailerName,
                          style: AppTypography.kBold20.copyWith(),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          retailer.email,
                          style: AppTypography.kBold14.copyWith(
                            color: AppColors.kPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.kPrimary.withOpacity(0.15),
              ),
              InfoRow(
                label: "Mobile No",
                value: retailer.mobileNumber,
              ),
              InfoRow(
                label: "Created Date",
                value: formatDate(retailer.createdAt.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yyyy').format(date);
    } catch (e) {
      return '';
    }
  }
}
