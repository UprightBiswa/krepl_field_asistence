import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../model/form_e_model.dart';
import 'form_e_list_view.dart';

class FormEDetailPage extends StatelessWidget {
  final FormE formE;

  const FormEDetailPage({super.key, required this.formE});

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
          'POP Material Details',
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
            FormECard(formE: formE),
            SizedBox(height: 10.h),
            _buildUserDetails(),
            SizedBox(height: 10.h),
            _buildFormDetails(),
            if (formE.remarks != '')
              _buildInfoCard('Remarks', formE.remarks!),
            SizedBox(height: 10.h),
            // Conditionally show the image if the URL is not empty
            if (formE.imageUrl.isNotEmpty)
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
                          formE.imageUrl,
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
                    formE.imageUrl,
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

  // Builds the information card for Activity and Party Type, etc.
  Widget _buildInfoCard(String title, String content) {
    return PrimaryContainer(
      padding: EdgeInsets.all(12.h),
      width: double.infinity, // Full width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(content, style: TextStyle(fontSize: 12.sp)),
        ],
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
              ...formE.formEUserDetails.map((userDetail) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Party Name: ${userDetail.partyName}',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      if (userDetail.mobileNo.isNotEmpty)
                        Text(
                          'Mobile: ${userDetail.mobileNo}',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                    ],
                  ),
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
          text: 'POP Material Details',
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        ...formE.formEDetails.map((detail) {
          return PrimaryContainer(
            padding: EdgeInsets.all(12.h),
            width: double.infinity, // Full width
            margin: EdgeInsets.only(bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Crop: ',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      detail.cropName,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stage: ',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      detail.cropStageName,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product: ',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      detail.productName,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pest: ',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      detail.pestName,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Season: ',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      detail.seasonName,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
