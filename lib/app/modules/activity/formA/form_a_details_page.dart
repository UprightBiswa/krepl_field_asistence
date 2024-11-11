import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/widgets.dart';
import '../model/form_a_model.dart';

class FormADetailPage extends StatelessWidget {
  final FormA formA;

  const FormADetailPage({super.key, required this.formA});

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
            InfoCard(title: 'Activity Type', content: formA.promotionActivityType),
            SizedBox(height: 10.h),
            InfoCard(title: 'Party Type', content: formA.partyType),
            SizedBox(height: 10.h),
            InfoCard(title: 'Activity Date', content: formA.createdAt),
            SizedBox(height: 10.h),
            UserDetailsCard(userDetails: formA.formAUserDetails),
            SizedBox(height: 10.h),
            _buildFormDetails(),
            SizedBox(height: 10.h),
            if (formA.remarks.isNotEmpty)
              InfoCard(title: 'Remarks', content: formA.remarks),
            SizedBox(height: 10.h),
            if (formA.imageUrl.isNotEmpty)
              PrimaryContainer(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Image.network(
                  formA.imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 200.h,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        ...formA.formADetails.map((detail) {
          return FormDetailsCard(detail: detail);
        }).toList(),
      ],
    );
  }
}


class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class FormDetailsCard extends StatelessWidget {
  final FormADetails detail;

  const FormDetailsCard({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: EdgeInsets.all(12.h),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Crop', detail.cropName),
          _buildRow('Stage', detail.cropStageName),
          _buildRow('Product', detail.productName),
          _buildRow('Pest', detail.pestName),
          _buildRow('Season', detail.seasonName),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp)),
        Text(value, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}

class UserDetailsCard extends StatelessWidget {
  final List<FormAUserDetails> userDetails;

  const UserDetailsCard({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User Details', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.h),
        PrimaryContainer(
          padding: EdgeInsets.all(12.h),
          width: double.infinity, // Full width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...userDetails.map((userDetail) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Party Name: ${userDetail.partyName}', style: TextStyle(fontSize: 12.sp)),
                      Text('Mobile: ${userDetail.mobileNo}', style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
