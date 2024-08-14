import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/route_list.dart';
import 'route_map_list_card.dart';

class RouteMapListView extends StatelessWidget {
  final List<RouteMap> route;

  const RouteMapListView({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return RouteMapListCard(
            route: route[index],
            index: index,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 20.w),
        itemCount: route.length,
      ),
    );
  }
}
