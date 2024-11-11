import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';

import '../../widgets/containers/primary_container.dart';
import '../model/form_d_model.dart';
import 'form_d_details_page.dart';

class FormDListView extends StatelessWidget {
  final PagingController<int, FormD> pagingController;

  const FormDListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FormD>(
      pagingController: pagingController,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      builderDelegate: PagedChildBuilderDelegate<FormD>(
        itemBuilder: (context, formD, index) => GestureDetector(
          onTap: () => Get.to(() => FormDDetailPage(formD: formD)),
          child: FormDCard(formD: formD),
        ),
        firstPageErrorIndicatorBuilder: (context) =>
            const Center(child: Text('Failed to load data')),
        noItemsFoundIndicatorBuilder: (context) =>
            const Center(child: Text('No data available')),
        newPageProgressIndicatorBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class FormDCard extends StatelessWidget {
  final FormD formD;

  const FormDCard({super.key, required this.formD});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Type: ${formD.promotionActivityType}',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text('Party Type: ${formD.partyType}', style: TextStyle(fontSize: 12.sp)),
          if (formD.remarks.isNotEmpty)
            Text('Remarks: ${formD.remarks}', style: TextStyle(fontSize: 12.sp)),
          Text('Total Party No: ${formD.totalPartyNo}', style: TextStyle(fontSize: 12.sp)),
          Text('Created At: ${formD.createdAt}', style: TextStyle(fontSize: 12.sp)),
          SizedBox(height: 10.h),

          ExpansionTile(
            title: Text('Details', style: TextStyle(fontSize: 12.sp)),
            children: formD.formDDetails.map((detail) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Crop Name: ${detail.cropName}', style: TextStyle(fontSize: 12.sp)),
                    Text('Stage: ${detail.cropStageName}', style: TextStyle(fontSize: 12.sp)),
                    Text('Product: ${detail.productName}', style: TextStyle(fontSize: 12.sp)),
                    Text('Pest: ${detail.pestName}', style: TextStyle(fontSize: 12.sp)),
                    Text('Season: ${detail.seasonName}', style: TextStyle(fontSize: 12.sp)),
                    SizedBox(height: 5.h),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10.h),

          ExpansionTile(
            title: Text('User Details', style: TextStyle(fontSize: 12.sp)),
            children: formD.formDUserDetails.map((userDetail) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Party Name: ${userDetail.partyName}', style: TextStyle(fontSize: 12.sp)),
                    Text('Mobile No: ${userDetail.mobileNo}', style: TextStyle(fontSize: 12.sp)),
                    SizedBox(height: 5.h),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
