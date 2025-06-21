import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    final FarmerController farmerController = Get.find<FarmerController>();

    return GestureDetector(
      onTap: () async {
        await Get.to<dynamic>(
          FarmerDetailView(
            farmer: farmer,
            tag: farmer.id.toString(),
          ),
        );
        farmerController.fetchRecentFarmers();
      },
      child: PrimaryContainer(
        padding: const EdgeInsets.all(0.0),
        width: 264.w,
        height: 200.h,
        child: Hero(
          tag: farmer.id,
          child: Stack(
            children: [
              // Background Image with Gradient Overlay
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: const DecorationImage(
                    image: NetworkImage(ImageDoctorUrl.farmerImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.9),
                        Colors.black.withValues(alpha: 0.6),
                        Colors.black.withValues(alpha: 0.4),
                        Colors.black.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              // Top-right ActionMenuIcon
              Positioned(
                top: 10.h,
                right: 10.w,
                child: ActionMenuIcon(
                  onEdit: () {
                    Get.to(() => FarmerEditForm(
                              farmer: farmer,
                              tag: farmer.id.toString(),
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
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      farmer.farmerName ?? 'Farmer Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      farmer.promotionActivity ?? 'Promotion Activity',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.white70, size: 16.sp),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            '${farmer.villageName ?? ''}, ${farmer.tehshil ?? ''}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.white70, size: 16.sp),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            'No: ${farmer.mobileNo ?? ''}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
