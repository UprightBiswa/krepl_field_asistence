import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../widgets/components/Info_row_widget.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'model/farmer_list.dart';

class FarmerDetailView extends StatefulWidget {
  final Farmer farmer;
  const FarmerDetailView({required this.farmer, super.key});

  @override
  State<FarmerDetailView> createState() => _FarmerDetailViewState();
}

class _FarmerDetailViewState extends State<FarmerDetailView> {
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Farmer Details',
          style: AppTypography.kBold20.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            DetailImageHeader(farmer: widget.farmer),
            Positioned(
              top: 228.h,
              left: 20.w,
              right: 20.w,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Segment 1: Farmer's Basic Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: widget.farmer.farmersName,
                            fontSize: 20.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Promotion Activity",
                            value: widget.farmer.promotionActivity,
                          ),
                          InfoRow(
                            label: "Father's Name",
                            value: widget.farmer.fatherName,
                          ),
                          InfoRow(
                            label: "Mobile Number",
                            value: widget.farmer.mobileNumber,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Segment 2: Farmer's Address Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: 'Address Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Village",
                            value: widget.farmer.villageLocalityName,
                          ),
                          InfoRow(
                            label: "Post Office",
                            value: widget.farmer.postOfficeName,
                          ),
                          InfoRow(
                            label: "Sub-District",
                            value: widget.farmer.subDistName,
                          ),
                          InfoRow(
                            label: "District",
                            value: widget.farmer.districtName,
                          ),
                          InfoRow(
                            label: "State",
                            value: widget.farmer.stateName,
                          ),
                          InfoRow(
                            label: "PIN",
                            value: widget.farmer.pin,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Segment 3: Field Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: 'Field Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Acre",
                            value: widget.farmer.acre.toString(),
                          ),
                          InfoRow(
                            label: "Cows Count",
                            value: widget.farmer.cowCount.toString(),
                          ),
                          InfoRow(
                            label: "Buffalos Count",
                            value: widget.farmer.buffaloCount.toString(),
                          ),
                          InfoRow(
                            label: "Work Place Code",
                            value: widget.farmer.workPlaceCode,
                          ),
                          InfoRow(
                            label: "Work Place Name",
                            value: widget.farmer.workPlaceName,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FarmerActionSheet(
        editCallback: () {
          // Logic for editing farmer details
        },
      ),
    );
  }
}

class DetailImageHeader extends StatelessWidget {
  final Farmer farmer;
  const DetailImageHeader({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(farmer.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 270.h,
            width: Get.width,
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  farmer.farmersName,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  farmer.promotionActivity,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class FarmerActionSheet extends StatelessWidget {
  final VoidCallback editCallback;
  const FarmerActionSheet({super.key, required this.editCallback});
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: isDarkMode(context)
            ? AppColors.kDarkSurfaceColor
            : AppColors.kInput,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              onTap: editCallback,
              text: "Edit Farmer Details",
            ),
          ),
        ],
      ),
    );
  }
}
