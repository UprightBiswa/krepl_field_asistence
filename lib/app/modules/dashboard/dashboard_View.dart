import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import 'component/dashboard_mtd.dart';
import 'component/dashboard_ytd.dart';


class DashboardView extends StatefulWidget {
  final UserDetails userDetails;

  const DashboardView({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: isDarkMode(context)
                    ? AppColors.kSecondary
                    : AppColors.kAccent4,
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                      ),
                      SizedBox(width: 8.w),
                      Text('YTD', style: AppTypography.kMedium14),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_view_month,
                      ),
                      SizedBox(width: 8.w),
                      Text('MTD', style: AppTypography.kMedium14),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: DashboardYTD(
                      userDetails: widget.userDetails,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: DashboardMTD(
                      userDetails: widget.userDetails,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
