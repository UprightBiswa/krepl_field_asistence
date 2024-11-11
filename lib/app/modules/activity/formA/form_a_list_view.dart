import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../widgets/containers/primary_container.dart';
import '../model/form_a_model.dart';
import 'form_a_details_page.dart';

class FormAListView extends StatelessWidget {
  final PagingController<int, FormA> pagingController;

  const FormAListView({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, FormA>(
      pagingController: pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<FormA>(
        itemBuilder: (context, formA, index) => GestureDetector(
          onTap: () => Get.to(() => FormADetailPage(formA: formA)),
          child: FormACard(formA: formA),
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

class FormACard extends StatelessWidget {
  final FormA formA;

  const FormACard({super.key, required this.formA});

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
                  formA.promotionActivityType,
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
              Text('Party Type: ${formA.partyType}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.groups, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Parties: ${formA.totalPartyNo}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey),
              SizedBox(width: 5.w),
              Text('Date: ${formA.createdAt}',
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
