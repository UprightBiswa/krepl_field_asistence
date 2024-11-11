// form_e_list_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';

import '../../widgets/containers/primary_container.dart';
import '../model/form_e_model.dart';
import 'form_e_details_page.dart';

class FormEListView extends StatelessWidget {
  final PagingController<int, FormE> pagingController;

  const FormEListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FormE>(
      pagingController: pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<FormE>(
        itemBuilder: (context, formE, index) => GestureDetector(
          onTap: () => Get.to(() => FormEDetailPage(formE: formE)),
          child: FormECard(formE: formE),
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

class FormECard extends StatelessWidget {
  final FormE formE;

  const FormECard({super.key, required this.formE});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.campaign, color: Colors.blueAccent, size: 20.sp),
              Expanded(
                child: Text(
                  formE.promotionActivityType,
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
              Icon(Icons.groups, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Parties: ${formE.totalPartyNo}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Date: ${formE.createdAt}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
