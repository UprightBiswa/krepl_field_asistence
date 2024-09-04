import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../farmer/controller/farmer_controller.dart';
import '../../farmer/farmer_details_view.dart';
import '../../farmer/model/farmer_list.dart';
import '../../widgets/containers/primary_container.dart';
import 'action_menue.dart';

class FarmerCard extends StatelessWidget {
  final Farmer farmer;
  const FarmerCard({required this.farmer, super.key});

  @override
  Widget build(BuildContext context) {
    final FarmerController farmerController = Get.put(FarmerController());

    return GestureDetector(
      onTap: () {
        Get.to<dynamic>(
          FarmerDetailView(
            farmer: farmer,
          ),
          transition: Transition.rightToLeftWithFade,
        )!
            .then((value) {
          farmerController.fetchRecentFarmers();
        });
      },
      child: PrimaryContainer(
        padding: const EdgeInsets.all(0.0),
        width: 264.w,
        height: 280.h,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Hero(
                tag: farmer.farmerName ?? '',
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.radiusFifteen),
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppAssets.kFarmer),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ActionMenuIcon(
                    onEdit: () {
                      // Add logic to edit the farmer details or icon
                    },
                    onDelete: () {
                      // Add logic to delete the farmer
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.all(AppSpacing.tenVertical),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      farmer.promotionActivity ?? '',
                      style: AppTypography.kBold14
                          .copyWith(color: AppColors.kPrimary),
                    ),
                    SizedBox(height: AppSpacing.tenVertical),
                    Text(
                      farmer.farmerName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.kBold20,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '🏠${farmer.acre}',
                          style: AppTypography.kBold14,
                        ),
                        const Spacer(),
                        Text(
                          'Contact: ${farmer.mobileNo}',
                          style: AppTypography.kLight16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
