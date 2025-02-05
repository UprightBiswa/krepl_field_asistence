import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../widgets/components/Info_row_widget.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/form_field.dart/form_hader.dart';
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
  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yyyy').format(date);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Retailer Details',
          style: AppTypography.kBold20.copyWith(color: AppColors.kWhite),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FormImageHeader(
              tag: widget.retailer.mobileNumber,
              image: ImageDoctorUrl.retailerImage,
              header: widget.retailer.retailerName,
              subtitle: widget.retailer.email,
            ),
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
                            label: "Code",
                            value: widget.retailer.code,
                          ),
                          InfoRow(
                            label: "Email",
                            value: widget.retailer.email,
                          ),
                          InfoRow(
                            label: "Mobile No",
                            value: widget.retailer.mobileNumber,
                          ),
                          InfoRow(
                            label: "Created Date",
                            value: formatDate(
                                widget.retailer.createdAt.toString()),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: widget.retailer.isActive == '1'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  widget.retailer.isActive == '1'
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: widget.retailer.isActive == '1'
                                      ? Colors.green
                                      : Colors.red,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  widget.retailer.isActive == '1'
                                      ? 'Active'
                                      : 'Inactive',
                                  style: TextStyle(
                                    color: widget.retailer.isActive == '1'
                                        ? Colors.green
                                        : Colors.red,
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
                    SizedBox(height: 20.h),
                    // Segment 2: Customer Details
                    if (widget.retailer.customerDetails.isNotEmpty)
                      PrimaryContainer(
                        child: Column(children: [
                          CustomHeaderText(
                            text: 'Customer Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          for (var customer in widget.retailer.customerDetails)
                            InfoRow(
                              label: customer.customerName,
                              value: customer.customerCode,
                            )
                        ]),
                      ),
                    SizedBox(height: 20.h),
                    // Segment 3: doctor's Address Details
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
      // bottomNavigationBar: DoctorActionSheet(
      //   editCallback: () {
      //     // Logic for editing doctor details
      //   },
      // ),
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
