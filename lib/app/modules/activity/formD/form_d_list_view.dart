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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.campaign, color: Colors.blueAccent, size: 20.sp),
              Expanded(
                child: Text(
                  formD.promotionActivityType,
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
              Text('Party Type: ${formD.partyType}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.contacts_outlined, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Total Party No: ${formD.totalPartyNo}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Date: ${formD.createdAt}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
