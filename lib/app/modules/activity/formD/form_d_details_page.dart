import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/components/Info_row_widget.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../formC/form_c_details_page.dart';
import '../model/form_d_model.dart';
import 'form_d_list_view.dart';

class FormDDetailPage extends StatelessWidget {
  final FormD formD;

  const FormDDetailPage({super.key, required this.formD});
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
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Demonstration Details',
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormDCard(formD: formD),
            SizedBox(height: 10.h),
            _buildUserDetails(),
            SizedBox(height: 10.h),
            _buildFormDetails(),
            SizedBox(height: 10.h),
            CustomHeaderText(
              text: 'Location',
              fontSize: 18.sp,
            ),
            SizedBox(height: 10.h),
            PrimaryContainer(
              padding: EdgeInsets.all(12.h),
              width: double.infinity, // Full width
              margin: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () {
                  String googleMapsUrl =
                      "https://www.google.com/maps/search/?api=1&query=${formD.latitude},${formD.longitude}";
                  launchUrl(Uri.parse(googleMapsUrl),
                      mode: LaunchMode.externalApplication);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(
                      label: 'Latitude',
                      value: formD.latitude,
                    ),
                    InfoRow(
                      label: 'Longitude',
                      value: formD.longitude,
                    ),
                    // show text to press go to the location with icons
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.kPrimary,
                        ),
                        Text(
                          'Press to go to the location',
                          style: AppTypography.kBold12.copyWith(
                            color: AppColors.kPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (formD.remarks.isNotEmpty)
              BuildInfoCard(title: 'Remarks', content: formD.remarks),
            SizedBox(height: 10.h),
            if (formD.imageUrl.isNotEmpty)
              GestureDetector(
                onTap: () {
                  //open a dialog show image and user can zoom
                  Get.dialog(
                    Dialog(
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          formD.imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                },
                child: PrimaryContainer(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Image.network(
                    formD.imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 200.h,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text('Failed to load image'),
                      );
                    },
                  ),
                ),
              ),
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
          text: 'Party Details',
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        PrimaryContainer(
          padding: EdgeInsets.all(12.h),
          width: double.infinity, // Full width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...formD.formDUserDetails.map((userDetail) {
                return InfoRow(
                  label: userDetail.partyName,
                  value: userDetail.mobileNo,
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
          text: 'Demo Details',
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        ...formD.formDDetails.map((detail) {
          return PrimaryContainer(
            padding: EdgeInsets.all(12.h),
            width: double.infinity, // Full width
            margin: EdgeInsets.only(bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoRow(
                  label: 'Crop',
                  value: detail.cropName,
                ),
                //stage
                InfoRow(
                  label: 'Stage',
                  value: detail.cropStageName,
                ),
                InfoRow(
                  label: 'Product',
                  value: detail.productName,
                ),

                InfoRow(
                  label: 'Pest',
                  value: detail.pestName,
                ),
                InfoRow(
                  label: 'Season',
                  value: detail.seasonName,
                ),
                // New fields (only show if they are not null)
                if (detail.dosage != null)
                  InfoRow(label: 'Dosage', value: detail.dosage!),
                if (detail.areaofdemo != null)
                  InfoRow(label: 'Demo Area', value: detail.areaofdemo!),
                if (detail.totalarea != null)
                  InfoRow(label: 'Total Area', value: detail.totalarea!),
                if (detail.expense != null)
                  InfoRow(label: 'Expense', value: detail.expense!),
              ],
            ),
          );
        }),
      ],
    );
  }
}
