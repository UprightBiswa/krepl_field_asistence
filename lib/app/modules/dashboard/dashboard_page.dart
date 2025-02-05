import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../landing_screens/components/gradient_appbar.dart';
import '../profile/settings_view.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/widgets.dart';
import 'component/customer_sales_continer.dart';
import 'component/mtd_tab_bar_data.dart';
import 'component/ytd_tab_bar_data.dart';
import 'controllers/activity_controller.dart';

class DashboardPage extends StatefulWidget {
  final UserDetails userDetails;

  const DashboardPage({super.key, required this.userDetails});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
// ActivityController
  final ActivityController controller = Get.put(ActivityController());
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();

    // Initialize TabController
    _tabController = TabController(length: 2, vsync: this);

    // Add listener to handle tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        // Call respective API based on the selected tab
        if (_tabController.index == 0) {
          fetchYtdData();
        } else if (_tabController.index == 1) {
          fetchMtdData();
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Dummy functions for API calls
  void fetchYtdData() {
    print('Fetching YTD Data...');
    // controller.fetchYtdData();
    // controller.fetchYtdSalesData();
  }

  void fetchMtdData() {
    print('Fetching MTD Data...');
    // Add your API call logic here
    // controller.fetchMtdData();
    // controller.fetchMtdSalesData();
  }

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
          style: AppTypography.kBold16,
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
            iconColor: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkSurfaceColor,
            color: AppColors.kWhite.withOpacity(0.15),
          ),
          SizedBox(width: AppSpacing.tenHorizontal),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.tenHorizontal,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: AppSpacing.radiusThirty,
                                  backgroundImage: AssetImage(AppAssets.kLogo),
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.userDetails.employeeName,
                                      style: AppTypography.kMedium15.copyWith(
                                        color: isDarkMode(context)
                                            ? AppColors.kWhite
                                            : AppColors.kGrey,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'ID: ${widget.userDetails.hrEmployeeCode}',
                                      style: AppTypography.kLight14.copyWith(
                                        color: isDarkMode(context)
                                            ? AppColors.kWhite
                                            : AppColors.kGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: isDarkMode(context)
                        ? AppColors.kBackground
                        : AppColors.kWhite,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode(context)
                          ? AppColors.kSecondary
                          : AppColors.kPrimary,
                    ),
                    indicatorWeight: 2,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today),
                            SizedBox(width: 8.w),
                            Text('YTD', style: AppTypography.kMedium14),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_view_month),
                            SizedBox(width: 8.w),
                            Text('MTD', style: AppTypography.kMedium14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSpacing.tenHorizontal),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    YTDTabBarData(
                      userDetails: widget.userDetails,
                    ),
                    SizedBox(height: 10.h),
                    CustomerSalesContainer(
                      userDetails: widget.userDetails,
                      isYtd: true,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSpacing.tenHorizontal),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    MTDTabBarData(
                      userDetails: widget.userDetails,
                    ),
                    SizedBox(height: 10.h),
                    CustomerSalesContainer(
                      userDetails: widget.userDetails,
                      isYtd: false,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height + 10.h;

  @override
  double get maxExtent => _tabBar.preferredSize.height + 10.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.tenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          PrimaryContainer(
            padding: EdgeInsets.zero,
            child: _tabBar,
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
