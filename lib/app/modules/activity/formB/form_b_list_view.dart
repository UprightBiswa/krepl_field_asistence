import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../widgets/containers/primary_container.dart';
import '../model/form_b_model.dart';
import 'form_b_details_page.dart';

class FormBListView extends StatelessWidget {
  final PagingController<int, FormB> pagingController;

  const FormBListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FormB>(
      pagingController: pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<FormB>(
        itemBuilder: (context, formB, index) => GestureDetector(
            onTap: () => Get.to(() => FormBDetailPage(formB: formB)),
            child: FormBCard(formB: formB)),
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

class FormBCard extends StatelessWidget {
  final FormB formB;

  const FormBCard({super.key, required this.formB});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.campaign, color: Colors.blueAccent, size: 20.sp),
              Expanded(
                child: Text(
                  formB.promotionActivityType,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.perm_identity, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Party Type: ${formB.partyType}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.groups, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Parties: ${formB.totalPartyNo}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Date: ${formB.createdAt}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          SizedBox(height: 10.h),
          // Display FormBDetails
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Text('Details', style: TextStyle(fontSize: 12.sp)),
            children: formB.formBDetails.map((detail) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Crop Name: ${detail.cropName}',
                        style: TextStyle(fontSize: 12.sp)),
                    Text('Stage: ${detail.cropStageName}',
                        style: TextStyle(fontSize: 12.sp)),
                    Text('Product: ${detail.productName}',
                        style: TextStyle(fontSize: 12.sp)),
                    Text('Pest: ${detail.pestName}',
                        style: TextStyle(fontSize: 12.sp)),
                    Text('Season: ${detail.seasonName}',
                        style: TextStyle(fontSize: 12.sp)),
                    SizedBox(height: 5.h),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10.h),

          // Display FormBUserDetails
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Text('User Details', style: TextStyle(fontSize: 12.sp)),
            children: formB.formBUserDetails.map((userDetail) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Party Name: ${userDetail.partyName}',
                        style: TextStyle(fontSize: 12.sp)),
                    Text('Route Name: ${userDetail.routeName}',
                        style: TextStyle(fontSize: 12.sp)),
                    Text('Mobile No: ${userDetail.mobileNo}',
                        style: TextStyle(fontSize: 12.sp)),
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
