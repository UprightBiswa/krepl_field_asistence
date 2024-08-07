import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../landing_screens/components/gradient_appbar.dart';
import '../profile/settings_view.dart';
import '../widgets/widgets.dart';
import 'components/best_teachers.dart';
import 'components/course_list.dart';
import 'components/custom_menu_card.dart';
import 'components/earning_card.dart';
import 'components/refer_friend_sheet.dart';
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

class _HomeViewState extends State<HomeView> {
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: GradientContainer(
          child: Container(),
        ),
        title: Text(
          'Home',
          style: AppTypography.kLight16.copyWith(
            color: isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
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
                  transition: Transition.rightToLeftWithFade);
            },
            icon: AppAssets.kSetting,
            iconColor: AppColors.kWhite,
            color: AppColors.kWhite.withOpacity(0.15),
          ),
          SizedBox(width: AppSpacing.twentyHorizontal),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text('Hi Emmy', style: AppTypography.kBold32),
              Text(
                'What do you want to do today? ☀️',
                style: AppTypography.kLight16,
              ),
              SizedBox(height: AppSpacing.thirtyVertical),
              GestureDetector(
                // onTap: () {
                //   Get.to<void>(() => const SearchView());
                // },
                child: SearchField(
                  controller: TextEditingController(),
                ),
              ),
              SizedBox(height: 26.h),
              EarningCard(
                title: 'Total Earnings',
                amount: r'$6,463',
                onSwipe: () {},
              ),
              SizedBox(height: 60.h),
              Text(
                'Latest on Emmy Design',
                style: AppTypography.kBold16,
              ),
              SizedBox(height: AppSpacing.twentyVertical),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomMenuCard(
                    isSelected: selectedIndex == 0,
                    onTap: () => handleCardTap(0),
                    icon: AppAssets.kPopular,
                    title: 'Popular',
                  ),
                  CustomMenuCard(
                    isSelected: selectedIndex == 1,
                    onTap: () => handleCardTap(1),
                    icon: AppAssets.kRecords,
                    title: 'Records',
                  ),
                  CustomMenuCard(
                    isSelected: selectedIndex == 2,
                    onTap: () => handleCardTap(2),
                    icon: AppAssets.kStatistics,
                    title: 'Statistics',
                  ),
                  CustomMenuCard(
                    isSelected: selectedIndex == 3,
                    onTap: () => handleCardTap(3),
                    icon: AppAssets.kStudents,
                    title: 'Students',
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.fiftyVertical),
              const CourseList(),
              SizedBox(height: 60..h),
              const BestTeachers(),
              SizedBox(height: AppSpacing.thirtyVertical),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.twentyHorizontal,
                ),
                child: Text(
                  'Refer a Friend',
                  style: AppTypography.kBold14,
                ),
              ),
              SizedBox(height: AppSpacing.twentyVertical),
              EarningCard(
                title: 'Total Referrals',
                amount: r'$92',
                onSwipe: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    builder: (context) {
                      return const ReferFriendSheet();
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
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
