import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../data/constrants/constants.dart';
import '../../../provider/connction_provider/connectivity_provider.dart';
import '../../home/components/action_menue.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/containers/primary_container.dart';
import '../controller/farmer_list_view_controller.dart';
import '../farmer_details_view.dart';
import '../model/farmer_list.dart';

class FarmerListCard extends StatefulWidget {
  final Farmer farmer;
  final int index;

  const FarmerListCard({required this.farmer, required this.index, super.key});

  @override
  State<FarmerListCard> createState() => _FarmerListCardState();
}

class _FarmerListCardState extends State<FarmerListCard> {
  final FarmerListController farmerController = Get.put(FarmerListController());

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, child) {
        return FadeIn(
          delay: const Duration(milliseconds: 500) * widget.index,
          child: AnimatedButton(
            onTap: () {
              Get.to<dynamic>(
                () => FarmerDetailView(farmer: widget.farmer),
                transition: Transition.rightToLeftWithFade,
              )!
                  .then((value) {
                farmerController.fetchFarmers(
                    1, farmerController.pagingController);
              });
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
                            ? // show 1st latter cercle text
                            CircleAvatar(
                                radius: 40.r,
                                backgroundColor: AppColors.kPrimary,
                                child: Text(
                                  widget.farmer.farmerName![0].toUpperCase(),
                                  style: AppTypography.kBold20.copyWith(
                                    color: AppColors.kWhite,
                                  ),
                                ),
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
                              widget.farmer.farmerName ?? '',
                              style: AppTypography.kBold20,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.farmer.promotionActivity ?? '',
                              style: AppTypography.kBold14.copyWith(
                                color: AppColors.kPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Contact: ${widget.farmer.mobileNo}',
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
