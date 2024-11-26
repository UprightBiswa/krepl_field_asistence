import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../profile/settings_view.dart';
import '../search/search_view.dart';
import '../widgets/widgets.dart';
import 'components/best_teachers.dart';
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

Widget _circularContainer(double height, Color color,
    {Color borderColor = Colors.transparent, double borderWidth = 2}) {
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
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    //app bar height for the current screen\ add a app status bar size
    final appBarHeight =
        AppBar().preferredSize.height + AppBar().preferredSize.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          height: Size.fromHeight(appBarHeight).height,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: AppColors.kPrimary,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: -150,
                right: -50,
                child: _circularContainer(
                    200, AppColors.kPrimary2.withOpacity(0.2)),
              ),
              Positioned(
                top: -100,
                right: -100,
                child: _circularContainer(
                    180, AppColors.kPrimary2.withOpacity(0.4)),
              ),
              Positioned(
                top: -100,
                left: -45,
                child: _circularContainer(
                    width * .5, AppColors.kPrimary2.withOpacity(0.2)),
              ),
              Positioned(
                top: -180,
                right: -30,
                child: _circularContainer(width * .7, Colors.transparent,
                    borderColor: Colors.white38),
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
                  transition: Transition.rightToLeftWithFade);
            },
            icon: AppAssets.kSetting,
            iconColor: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkSurfaceColor,
            color: AppColors.kWhite.withOpacity(0.15),
          ),
          SizedBox(width: AppSpacing.tenHorizontal),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.kPrimary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kPrimary.withOpacity(0.5),
                      blurRadius: 0,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.twentyHorizontal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: AppColors.kWhite.withOpacity(0.8),
                            child: Text(
                              widget.userDetails.employeeName[0].toUpperCase(),
                              style: AppTypography.kBold20.copyWith(
                                color: AppColors.kPrimary,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: AppTypography.kLight14
                                    .copyWith(color: AppColors.kWhite),
                              ),
                              Text(
                                '${widget.userDetails.employeeName} 👋',
                                style: AppTypography.kBold16
                                    .copyWith(color: AppColors.kWhite),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          Get.to<void>(
                            () => const SearchView(),
                            transition: Transition.rightToLeftWithFade,
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
              Padding(
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
                    const BestTeachers(),
                    SizedBox(height: 20.h),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
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
