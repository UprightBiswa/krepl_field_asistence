import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../data/constrants/constants.dart';
import '../../../provider/connction_provider/connectivity_provider.dart';
import '../../home/components/action_menue.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/containers/primary_container.dart';
import '../farmer_details_view.dart';
import '../model/farmer_list.dart';

class FarmerListCard extends StatelessWidget {
  final Farmer farmer;
  final int index;

  const FarmerListCard({required this.farmer, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, child) {
        return FadeIn(
          delay: const Duration(milliseconds: 500) * index,
          child: AnimatedButton(
            onTap: () {
              Get.to<dynamic>(
                FarmerDetailView(farmer: farmer),
                transition: Transition.rightToLeftWithFade,
              );
            },
            child: PrimaryContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: connectivityProvider.isConnected
                            ? CachedNetworkImage(
                                imageUrl: farmer.image,
                                placeholder: (BuildContext context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  AppAssets.kLogo,
                                  width: 80.w,
                                  height: 80.w,
                                  fit: BoxFit.cover,
                                ),
                                width: 80.w,
                                height: 80.w,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppAssets.kLogo,
                                width: 80.w,
                                height: 80.w,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 16.w),
                      // Farmer details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              farmer.farmersName,
                              style: AppTypography.kBold20,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              farmer.promotionActivity,
                              style: AppTypography.kBold14.copyWith(
                                color: AppColors.kPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Contact: ${farmer.mobileNumber}',
                              style: AppTypography.kLight16.copyWith(
                                color: AppColors.kNeutral04.withOpacity(0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action menu icon
                      ActionMenuIcon(
                        onEdit: () {
                          // Edit farmer logic
                        },
                        onDelete: () {
                          // Delete farmer logic
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
