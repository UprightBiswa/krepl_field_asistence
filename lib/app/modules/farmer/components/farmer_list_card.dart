import 'package:animate_do/animate_do.dart';
import 'package:field_asistence/app/modules/farmer/farmer_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/constrants/constants.dart';
import '../../../provider/connction_provider/connectivity_provider.dart';
import '../../home/components/action_menue.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/components/Info_row_widget.dart';
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
                () => FarmerDetailView(
                  farmer: widget.farmer,
                  tag: widget.farmer.mobileNo ?? '',
                ),
                transition: Transition.rightToLeftWithFade,
              )!
                  .then((value) {
                // farmerController.fetchFarmers(
                //     1, farmerController.pagingController);
                farmerController.refreshItems();
              });
            },
            child: PrimaryContainer(
              padding: EdgeInsets.all(10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: AppColors.kPrimary,
                        child: Text(
                          widget.farmer.farmerName!
                              .substring(0, 2)
                              .toUpperCase(),
                          style: AppTypography.kBold14.copyWith(
                            color: AppColors.kWhite,
                          ),
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
                          ],
                        ),
                      ),
                      // Action menu icon
                      ActionMenuIcon(
                        onEdit: () {
                          // Edit farmer logic
                          Get.to(() => FarmerEditForm(
                                    farmer: widget.farmer,
                                    tag: widget.farmer.mobileNo ?? '',
                                  ))!
                              .then((value) {
                            // farmerController.fetchFarmers(
                            //     1, farmerController.pagingController);
                            farmerController.refreshItems();
                            Get.back();
                          });
                        },
                        onDelete: () {},
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.kPrimary.withOpacity(0.15),
                  ),
                  InfoRow(
                    label: "Mobile No",
                    value: widget.farmer.mobileNo ?? '',
                  ),
                  InfoRow(
                    label: "Created Date",
                    value: formatDate(widget.farmer.createdAt.toString()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
