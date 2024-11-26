import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/containers/primary_container.dart';
import '../controller/retailer_controller.dart';
import '../retailer_details_view.dart';
import '../model/retailer_model_list.dart';

class RetailerListCard extends StatelessWidget {
  final Retailer retailer;
  final int index;

  const RetailerListCard(
      {required this.retailer, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerController retailerController = Get.put(RetailerController());

    return FadeIn(
      delay: const Duration(milliseconds: 500) * index,
      child: AnimatedButton(
        onTap: () {
          Get.to<dynamic>(
            RetailerDetailView(
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
          // width: 264.w,
          // height: 150.h,
          child: Row(
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
                    SizedBox(height: 8.h),
                    Text(
                      'No: ${retailer.mobileNumber}',
                      style: AppTypography.kLight16.copyWith(
                        color: AppColors.kNeutral04.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),
              // // Action menu icon
              // ActionMenuIcon(
              //   onEdit: () {
              //     // Edit doctor logic
              //   },
              //   onDelete: () {
              //     // Delete doctor logic
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
