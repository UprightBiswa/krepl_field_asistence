import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../model/retailer_model_list.dart';
import 'retailer_list_card.dart';

class RetailerListView extends StatefulWidget {
  final PagingController<int, Retailer> pagingController;

  const RetailerListView({
    super.key,
    required this.pagingController,
  });

  @override
  State<RetailerListView> createState() => _RetailerListViewState();
}

class _RetailerListViewState extends State<RetailerListView> {
  @override
  Widget build(BuildContext context) {
    return PagingListener<int, Retailer>(
      controller: widget.pagingController,
      builder: (context, state, fetchNextPage) {
        return PagedListView<int, Retailer>.separated(
          state: state,
          fetchNextPage: fetchNextPage,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.none,
          builderDelegate: PagedChildBuilderDelegate<Retailer>(
            itemBuilder: (context, doctor, index) {
              return RetailerListCard(
                retailer: doctor,
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
    );
  }
}
