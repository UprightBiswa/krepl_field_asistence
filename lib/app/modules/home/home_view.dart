import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../profile/settings_view.dart';
import '../search/search_view.dart';
import '../widgets/widgets.dart';
import 'components/farmer_list.dart';
import 'components/today_status_card.dart';
import 'components/menus_continer.dart';
import 'components/search_field.dart';

class HomeView extends StatefulWidget {
  final UserDetails userDetails;
  const HomeView({
    super.key,
    required this.userDetails,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

Widget _circularContainer(
  double height,
  Color color, {
  Color borderColor = Colors.transparent,
  double borderWidth = 2,
}) {
  return Container(
    height: height,
    width: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(color: borderColor, width: borderWidth),
    ),
  );
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: AppColors.kPrimary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimary.withAlpha(100),
                blurRadius: 0,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: -50,
                right: -50,
                child: _circularContainer(
                    150, AppColors.kPrimary2.withValues(alpha: .3)),
              ),
              Positioned(
                top: -80,
                right: -80,
                child: _circularContainer(
                    200, AppColors.kPrimary2.withValues(alpha: .2)),
              ),
            ],
          ),
        ),
        title: Text('Home', style: AppTypography.kBold16),
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
            iconColor: AppColors.kDarkSurfaceColor,
            color: AppColors.kWhite.withValues(alpha: .15),
          ),
          SizedBox(width: AppSpacing.tenHorizontal),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.tenHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    Get.to<void>(
                      () => const SearchView(),
                      transition: Transition.cupertino,
                    );
                  },
                  child: SearchField(
                    controller: TextEditingController(),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.twentyHorizontal,
        ),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const ShortcutMenus(),
            SizedBox(height: 20.h),
            TodayStatusCard(
              userDetails: widget.userDetails,
            ),
            const FarmerList(),
            SizedBox(height: 20.h),
            const ReportView(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  int selectedIndex = 0;

  void handleCardTap(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
      } else {
        selectedIndex = index;
        if (selectedIndex == 1) {
          Future.delayed(const Duration(milliseconds: 500), () {
            // Get.to<void>(() => const CourseSchedule());
          });
        }
        if (selectedIndex == 2) {
          Future.delayed(const Duration(milliseconds: 500), () {
            // Get.to<void>(() => const StatisticsView());
          });
        }
      }
    });
  }
}
