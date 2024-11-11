import 'package:field_asistence/app/modules/activity/model/form_c_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/widgets.dart';
import 'form_c_list_view.dart';

class FormCDetailPage extends StatelessWidget {
  final FormC formC;

  const FormCDetailPage({super.key, required this.formC});

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    int totalQuantity(List<FormCDetail> formCDetails) {
      int total = 0;
      for (var i = 0; i < formCDetails.length; i++) {
        total += int.parse(formCDetails[i].quantity);
      }
      return total;
    }

    int totalExpense(List<FormCDetail> formCDetails) {
      int total = 0;
      for (var i = 0; i < formCDetails.length; i++) {
        total += int.parse(formCDetails[i].expense);
      }
      return total;
    }

    int totalProduct(List<FormCDetail> formCDetails) {
      int total = formCDetails.length;

      return total;
    }

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
            FormCSummary(
              totalQuantity: totalQuantity(formC.formCDetails),
              totalExpense: totalExpense(formC.formCDetails).toDouble(),
              totalProduct: totalProduct(formC.formCDetails),
            ),
            SizedBox(height: 10.h),
            _buildInfoCard(
                title: 'Activity Type', content: formC.promotionActivityType),
            SizedBox(height: 10.h),
            _buildInfoCard(title: 'Party Type', content: formC.partyType),
            SizedBox(height: 10.h),
            _buildInfoCard(title: 'Activity Date', content: formC.createdAt),
            SizedBox(height: 10.h),
            Text(
              'User Details',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ...formC.formCDetails.map(
              (detail) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _FormCDetailCard(detail: detail),
              ),
            ),
            if (formC.remarks.isNotEmpty)
              _buildInfoCard(title: 'Remarks', content: formC.remarks),
          ],
        ),
      ),
    );
  }
}

class _buildInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const _buildInfoCard({
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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return PrimaryContainer(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.partyName.isEmpty ? 'Party Name' : detail.partyName,
            style: AppTypography.kBold14.copyWith(
              color: isDarkMode ? AppColors.kWhite : AppColors.kDarkContiner,
            ),
          ),
          SizedBox(height: 10.h),
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
