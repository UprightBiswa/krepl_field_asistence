import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../../data/helpers/data/image_doctor_url.dart';
import '../../farmer/controller/farmer_controller.dart';
import '../../farmer/farmer_details_view.dart';
import '../../farmer/farmer_edit_form.dart';
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
            tag: farmer.mobileNo ?? '',
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
        height: 260.h,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Hero(
                tag: farmer.mobileNo ?? '',
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.radiusFifteen),
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(ImageDoctorUrl.farmerImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ActionMenuIcon(
                    onEdit: () {
                      // Edit farmer logic
                      Get.to(() => FarmerEditForm(
                                farmer: farmer,
                                tag: farmer.mobileNo ?? '',
                              ))!
                          .then((value) {
                        farmerController.fetchRecentFarmers();
                        Get.back();
                      });
                    },
                    onDelete: () {
                      // Add logic to delete the farmer
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(AppSpacing.tenVertical),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      farmer.farmerName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.kBold14
                          .copyWith(color: AppColors.kPrimary),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      farmer.promotionActivity ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.kBold14,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${farmer.villageName}, ${farmer.tehshil}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.kBold12,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Text(
                            'No: ${farmer.mobileNo}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.kBold12,
                          ),
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
