import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../farmer/farmer_details_view.dart';
import '../../farmer/model/farmer_list.dart';
import '../../widgets/containers/primary_container.dart';
import 'action_menue.dart';

class FarmerCard extends StatelessWidget {
  final Farmer farmer;
  const FarmerCard({required this.farmer, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to<dynamic>(
          FarmerDetailView(
            farmer: farmer,
          ),
          transition: Transition.rightToLeftWithFade,
        );
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
                tag: farmer.farmersName,
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.radiusFifteen),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(farmer.image),
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
                      farmer.promotionActivity,
                      style: AppTypography.kBold14
                          .copyWith(color: AppColors.kPrimary),
                    ),
                    SizedBox(height: AppSpacing.tenVertical),
                    Text(
                      farmer.farmersName,
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
                          'Contact: ${farmer.mobileNumber}',
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
