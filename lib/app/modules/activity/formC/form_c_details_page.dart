import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:field_asistence/app/modules/activity/model/form_c_model.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import 'form_c_list_view.dart';

class FormCDetailPage extends StatelessWidget {
  final FormC formC;

  const FormCDetailPage({super.key, required this.formC});

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
          'Dealer Stock Details',
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
            FormCCard(
              formC: formC,
            ),
            SizedBox(height: 10.h),
            CustomHeaderText(
              text: 'User Details',
              fontSize: 18.sp,
            ),
            SizedBox(height: 10.h),
            ...formC.formCDetails.map(
              (detail) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _FormCDetailCard(detail: detail),
              ),
            ),
            if (formC.remarks.isNotEmpty)
              BuildInfoCard(title: 'Remarks', content: formC.remarks),
          ],
        ),
      ),
    );
  }
}

class BuildInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const BuildInfoCard({
    super.key,
    required this.title,
    required this.content,
  });

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

class _FormCDetailCard extends StatelessWidget {
  final FormCDetail detail;

  const _FormCDetailCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detail.partyName.isNotEmpty)
            _DetailRow(label: 'Party Name', value: detail.partyName),
          _DetailRow(label: 'Mobile No', value: detail.mobileNo),
          _DetailRow(label: 'Product Name', value: detail.productName),
          _DetailRow(label: 'Quantity', value: detail.quantity),
          _DetailRow(label: 'Expense', value: detail.expense),
        ],
      ),
    );
  }

  _DetailRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        Text(value, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
