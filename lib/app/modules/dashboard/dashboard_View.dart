import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../landing_screens/components/gradient_appbar.dart';
import '../profile/settings_view.dart';
import '../widgets/widgets.dart';
import 'component/dashboard_mtd.dart';
import 'component/dashboard_ytd.dart';

class DashboardView extends StatefulWidget {
  final UserDetails userDetails;

  const DashboardView({super.key, required this.userDetails});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: GradientContainer(
          child: Container(),
        ),
        title: Text(
          'Dashboard',
          style: AppTypography.kLight16.copyWith(
            color: AppColors.kGrey,
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onTap: () {
              Get.to<dynamic>(
                SettingsView(
                  userDetails: widget.userDetails,
                ),
              );
            },
            icon: AppAssets.kSetting,
            iconColor: AppColors.kWhite,
            color: AppColors.kWhite.withValues(alpha: 0.15),
          ),
          SizedBox(width: AppSpacing.twentyHorizontal),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: AppColors.kAccent4,
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
