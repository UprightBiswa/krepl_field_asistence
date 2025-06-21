import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/route_list.dart';
import 'route_action_mene.dart';

class RouteMapListCard extends StatelessWidget {
  final RouteMap route;
  final int index;

  const RouteMapListCard({required this.route, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 200) * index,
      child: AnimatedButton(
        onTap: () {
          // Navigate to route detail view
        },
        child: PrimaryContainer(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              //add devider
              Divider(
                color: AppColors.kNeutral04.withValues(alpha: .5),
                thickness: 1.h,
                height: 25.h,
              ),

              _buildFooter(context),
              // _buildDetails(context),
              SizedBox(height: 8.h),
              _buildCounts(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Circular image of the route
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: AppColors.kPrimary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(25.r),
          ),
          alignment: Alignment.center,
          child: Text(
            route.routeName.substring(0, 2).toUpperCase(),
            style: AppTypography.kBold20.copyWith(
              color: AppColors.kPrimary,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Route details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                route.routeName,
                style: AppTypography.kBold20.copyWith(
                  color: AppColors.kDarkContiner,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "${route.fromDate.day.toString().padLeft(2, '0')}/${route.fromDate.month.toString().padLeft(2, '0')}/${route.fromDate.year} - ${route.toDate.day.toString().padLeft(2, '0')}/${route.toDate.month.toString().padLeft(2, '0')}/${route.toDate.year}",
                style: AppTypography.kLight16.copyWith(
                  color: AppColors.kNeutral04.withValues(alpha: .75),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCounts(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCountCard('Employees', route.employees.length,
            route.employees.map((e) => e.empName).toList(), context),
        _buildCountCard('Workplaces', route.workPlaces.length,
            route.workPlaces.map((w) => w.workPlaceName).toList(), context),
        _buildCountCard('Villages', route.villages.length,
            route.villages.map((v) => v.villageName).toList(), context),
      ],
    );
  }

  Widget _buildCountCard(
      String label, int count, List<String> items, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModalBottomSheet(context, label, items);
      },
      child: Column(
        children: [
          Text(
            count.toString(),
            style: AppTypography.kBold20.copyWith(
              color: AppColors.kDarkContiner,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTypography.kLight16.copyWith(
              color: AppColors.kNeutral04.withValues(alpha: .75),
            ),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(
      BuildContext context, String label, List<String> items) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTypography.kBold16
                    .copyWith(color: AppColors.kDarkContiner),
              ),
              SizedBox(height: 16.h),
              ...items.map((item) => ListTile(title: Text(item))).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getStatusText(route.status),
          style: AppTypography.kBold16.copyWith(
            color: getStatusColor(route.status),
          ),
        ),
        RouteActionMenu(
          status: route.status,
          onActivate: () {
            // Implement activate logic
          },
          onDeactivate: () {
            // Implement deactivate logic
          },
          onDelete: () {
            // Implement delete logic
          },
        ),
      ],
    );
  }

  String getStatusText(RouteStatus status) {
    switch (status) {
      case RouteStatus.Active:
        return "Active";
      case RouteStatus.Deactive:
        return "Deactive";
      case RouteStatus.Delete:
        return "Deleted";
      }
  }

  Color getStatusColor(RouteStatus status) {
    switch (status) {
      case RouteStatus.Active:
        return Colors.green;
      case RouteStatus.Deactive:
        return Colors.red;
      case RouteStatus.Delete:
        return Colors.grey;
    }
  }
}
