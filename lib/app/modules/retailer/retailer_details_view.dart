import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../widgets/components/Info_row_widget.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'model/retailer_model_list.dart';

class RetailerDetailView extends StatefulWidget {
  final Retailer retailer;
  const RetailerDetailView({required this.retailer, super.key});

  @override
  State<RetailerDetailView> createState() => _RetailerDetailViewState();
}

class _RetailerDetailViewState extends State<RetailerDetailView> {
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
          'Retailer Details',
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
            DetailImageHeader(retailer: widget.retailer),
            Positioned(
              top: 228.h,
              left: 20.w,
              right: 20.w,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Segment 1: doctor's Basic Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: widget.retailer.retailerName,
                            fontSize: 20.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Email Address",
                            value: widget.retailer.email,
                          ),
                          InfoRow(
                            label: "Mobile Number",
                            value: widget.retailer.mobileNumber,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Segment 2: doctor's Address Details
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
                            value: widget.retailer.villageName,
                          ),
                          InfoRow(
                            label: "Post Office",
                            value: widget.retailer.postOfficeName,
                          ),
                          InfoRow(
                            label: "Sub-District",
                            value: widget.retailer.subDistName,
                          ),
                          InfoRow(
                            label: "District",
                            value: widget.retailer.districtName,
                          ),
                          InfoRow(
                            label: "State",
                            value: widget.retailer.stateName,
                          ),
                          InfoRow(
                            label: "PIN",
                            value: widget.retailer.pinCode,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Segment 3: Customer Details
                    if (widget.retailer.customerDetails.isNotEmpty)
                      PrimaryContainer(
                        child: Column(
                          children: [
                            CustomHeaderText(
                              text: 'Customer Details',
                              fontSize: 18.sp,
                            ),
                            SizedBox(height: 16.h),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.retailer.customerDetails.length,
                              itemBuilder: (context, index) {
                                final customer =
                                    widget.retailer.customerDetails[index];
                                return InfoRow(
                                  label: customer.customerName != ''
                                      ? customer.customerName
                                      : "Customer Name",
                                  value: customer.customerCode,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 20.h),
                    // Segment 4: Field Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: 'Field Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Work Place Code",
                            value: widget.retailer.workplaceCode,
                          ),
                          InfoRow(
                            label: "Work Place Name",
                            value: widget.retailer.workplaceName,
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
      bottomNavigationBar: DoctorActionSheet(
        editCallback: () {
          // Logic for editing doctor details
        },
      ),
    );
  }
}

class DetailImageHeader extends StatelessWidget {
  final Retailer retailer;
  const DetailImageHeader({super.key, required this.retailer});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: Get.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(ImageDoctorUrl.doctorImage),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      retailer.retailerName,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      retailer.mobileNumber,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    color: retailer.isActive
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        retailer.isActive ? Icons.check_circle : Icons.cancel,
                        color: retailer.isActive ? Colors.green : Colors.red,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        retailer.isActive ? 'Active' : 'Inactive',
                        style: TextStyle(
                          color: retailer.isActive ? Colors.green : Colors.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

class DoctorActionSheet extends StatefulWidget {
  final VoidCallback editCallback;
  const DoctorActionSheet({
    super.key,
    required this.editCallback,
  });

  @override
  State<DoctorActionSheet> createState() => _DoctorActionSheetState();
}

class _DoctorActionSheetState extends State<DoctorActionSheet> {
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
              onTap: widget.editCallback,
              text: "Edit Retailer Details",
            ),
          ),
        ],
      ),
    );
  }
}
