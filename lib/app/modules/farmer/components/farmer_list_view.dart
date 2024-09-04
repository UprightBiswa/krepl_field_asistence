import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../model/farmer_list.dart';
import 'farmer_list_card.dart';

class FarmerListView extends StatefulWidget {
  final PagingController<int, Farmer> pagingController;

  const FarmerListView({
    super.key,
    required this.pagingController,
  });

  @override
  State<FarmerListView> createState() => _FarmerListViewState();
}

class _FarmerListViewState extends State<FarmerListView> {


  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      // return PagedListView<int, Farmer>(
      pagingController: widget.pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      clipBehavior: Clip.none,
      builderDelegate: PagedChildBuilderDelegate<Farmer>(
        itemBuilder: (context, farmer, index) {
          return FarmerListCard(
            farmer: farmer,
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
          child: Text('No more items to load'),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
    );
  }
}
