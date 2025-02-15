import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../formC/form_c_details_page.dart';
import '../model/form_b_model.dart';
import 'form_b_list_view.dart';

class FormBDetailPage extends StatelessWidget {
  final FormB formB;

  const FormBDetailPage({super.key, required this.formB});

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withAlpha(50),
        title: Text(
          'Campaign Details',
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBCard(
              formB: formB,
            ),
            SizedBox(height: 10.h),
            _buildUserDetails(),
            SizedBox(height: 10.h),
            _buildFormDetails(),
            SizedBox(height: 10.h),
            if (formB.remarks != null)
              BuildInfoCard(title: 'Remarks', content: formB.remarks!),
          ],
        ),
      ),
    );
  }

  // Builds the User Details section
  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderText(
          text: 'Village Details',
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        PrimaryContainer(
          padding: EdgeInsets.all(12.h),
          width: double.infinity, // Full width
          margin: EdgeInsets.only(bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...formB.formBUserDetails.map((userDetail) {
                return Column(
                  spacing: 5.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userDetail.partyName.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.green, size: 16.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              userDetail.partyName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),

                    if (userDetail.routeName.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.route, color: Colors.blue, size: 16.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              userDetail.routeName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    // if(its last index dont shoe)
                    if (formB.formBUserDetails.indexOf(userDetail) !=
                        formB.formBUserDetails.length - 1)
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // Builds the Form Details section
  Widget _buildFormDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderText(
          text: 'Campaign Details',
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        ...formB.formBDetails.map((detail) {
          return PrimaryContainer(
            padding: EdgeInsets.all(12.h),
            width: double.infinity, // Full width
            margin: EdgeInsets.only(bottom: 10.h),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                    Icons.shopping_bag, 'Product', detail.productName),
                _buildDetailRow(Icons.eco, 'Crop', detail.cropName),
                _buildDetailRow(Icons.timeline, 'Stage', detail.cropStageName),
                _buildDetailRow(Icons.bug_report, 'Pest', detail.pestName),
                _buildDetailRow(
                    Icons.calendar_today, 'Season', detail.seasonName),
              ],
            ),
          );
        }),
      ],
    );
  }

// Widget for reusable row with icon
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[700],
            ),
          ),
        ],
      ),
    );
  }
}
