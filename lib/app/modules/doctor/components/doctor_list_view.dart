import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../model/doctor_list.dart';
import 'doctor_list_card.dart';

class DoctorListView extends StatefulWidget {
  final PagingController<int, Doctor> pagingController;

  const DoctorListView({
    super.key,
    required this.pagingController,
  });

  @override
  State<DoctorListView> createState() => _DoctorListViewState();
}

class _DoctorListViewState extends State<DoctorListView> {
  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      // return PagedListView<int, Farmer>(
      pagingController: widget.pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      clipBehavior: Clip.none,
      builderDelegate: PagedChildBuilderDelegate<Doctor>(
        itemBuilder: (context, doctor, index) {
          return DoctorListCard(
            doctor: doctor,
            index: index,
          );
        },
        newPageProgressIndicatorBuilder: (_) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        noItemsFoundIndicatorBuilder: (_) => const Center(
          child: Text('No Data Available'),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
    );
  }
}
