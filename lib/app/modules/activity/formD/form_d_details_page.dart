import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/widgets.dart';
import '../model/form_d_model.dart';

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
          formD.promotionActivityType,
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: PrimaryContainer(
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Activity Type: ${formD.promotionActivityType}',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              Text('Party Type: ${formD.partyType}',
                  style: TextStyle(fontSize: 14.sp)),
              if (formD.remarks.isNotEmpty)
                Text('Remarks: ${formD.remarks}',
                    style: TextStyle(fontSize: 14.sp)),
              Text('Total Party No: ${formD.totalPartyNo}',
                  style: TextStyle(fontSize: 14.sp)),
              Text('Created At: ${formD.createdAt}',
                  style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 10.h),
              ExpansionTile(
                title: Text('Details', style: TextStyle(fontSize: 14.sp)),
                children: formD.formDDetails.map((detail) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Crop Name: ${detail.cropName}',
                            style: TextStyle(fontSize: 14.sp)),
                        Text('Stage: ${detail.cropStageName}',
                            style: TextStyle(fontSize: 14.sp)),
                        Text('Product: ${detail.productName}',
                            style: TextStyle(fontSize: 14.sp)),
                        Text('Pest: ${detail.pestName}',
                            style: TextStyle(fontSize: 14.sp)),
                        Text('Season: ${detail.seasonName}',
                            style: TextStyle(fontSize: 14.sp)),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10.h),
              ExpansionTile(
                title: Text('User Details', style: TextStyle(fontSize: 14.sp)),
                children: formD.formDUserDetails.map((userDetail) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Party Name: ${userDetail.partyName}',
                            style: TextStyle(fontSize: 14.sp)),
                        Text('Mobile No: ${userDetail.mobileNo}',
                            style: TextStyle(fontSize: 14.sp)),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
