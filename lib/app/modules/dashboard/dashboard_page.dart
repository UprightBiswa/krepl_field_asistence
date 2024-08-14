import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../landing_screens/components/gradient_appbar.dart';
import '../profile/settings_view.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/widgets.dart';
import 'component/mtb_tab_bar_data.dart';
import 'component/ytd_tab_bar_data.dart';

class DashboardPage extends StatefulWidget {
  final UserDetails userDetails;

  const DashboardPage({super.key, required this.userDetails});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
          SizedBox(width: AppSpacing.twentyHorizontal),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    PrimaryContainer(
                      radius: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
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
                                    'ID: ${widget.userDetails.employeeCode}',
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
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kPrimary,
                    indicatorColor: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kPrimary,
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
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: YTDTabBarData(
                  userDetails: widget.userDetails,
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: MTDTabBarData(
                  userDetails: widget.userDetails,
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
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PrimaryContainer(
      radius: 0,
      padding: const EdgeInsets.all(0),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../../data/constrants/constants.dart';
// import '../../model/login/user_details_reponse.dart';
// import '../landing_screens/components/gradient_appbar.dart';
// import '../profile/settings_view.dart';
// import '../widgets/widgets.dart';
// import 'component/dashboard_mtd.dart';
// import 'component/dashboard_ytd.dart';


// class DashboardPage extends StatefulWidget {
//   final UserDetails userDetails;

//   const DashboardPage({super.key, required this.userDetails});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   bool isDarkMode(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           flexibleSpace: GradientContainer(
//             child: Container(),
//           ),
//           title: Text(
//             'Dashboard',
//             style: AppTypography.kLight16.copyWith(
//               color: isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
//             ),
//           ),
//           centerTitle: true,
//           actions: [
//             CustomIconButton(
//               onTap: () {
//                 Get.to<dynamic>(
//                   SettingsView(userDetails: widget.userDetails),
//                   transition: Transition.rightToLeftWithFade,
//                 );
//               },
//               icon: AppAssets.kSetting,
//               iconColor: AppColors.kWhite,
//               color: AppColors.kWhite.withOpacity(0.15),
//             ),
//             SizedBox(width: AppSpacing.twentyHorizontal),
//           ],
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Today'),
//               Tab(text: 'Target (MTD)'),
//               Tab(text: 'Achieved (MTD)'),
//               Tab(text: 'Sales'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildTodayActivityTab(),
//             _buildTargetActivityTab(),
//             _buildAchievedActivityTab(),
//             _buildSalesTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTodayActivityTab() {
//     return ListView(
//       padding: EdgeInsets.all(8.0),
//       children: [
//         _buildActivityCard('Village Coverage', '10', '15', Icons.location_on),
//         _buildActivityCard('New Farmer Registration', '5', '10', Icons.person_add),
//         // Add more cards...
//       ],
//     );
//   }

//   Widget _buildTargetActivityTab() {
//     return ListView(
//       padding: EdgeInsets.all(8.0),
//       children: [
//         _buildActivityCard('Village Coverage', '100', '150', Icons.location_on),
//         _buildActivityCard('New Farmer Registration', '50', '100', Icons.person_add),
//         // Add more cards...
//       ],
//     );
//   }

//   Widget _buildAchievedActivityTab() {
//     return ListView(
//       padding: EdgeInsets.all(8.0),
//       children: [
//         _buildActivityCard('Village Coverage', '80', '150', Icons.location_on),
//         _buildActivityCard('New Farmer Registration', '45', '100', Icons.person_add),
//         // Add more cards...
//       ],
//     );
//   }

//   Widget _buildSalesTab() {
//     return ListView(
//       padding: EdgeInsets.all(8.0),
//       children: [
//         _buildSalesCard('Customer A', '50', '20', '60', '30'),
//         _buildSalesCard('Customer B', '40', '15', '50', '25'),
//         // Add more cards...
//       ],
//     );
//   }

//   Widget _buildActivityCard(String title, String today, String target, IconData icon) {
//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: ListTile(
//         leading: Icon(icon, size: 40.0, color: Colors.blueAccent),
//         title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Today: $today', style: TextStyle(color: Colors.grey)),
//             Text('Target: $target', style: TextStyle(color: Colors.green)),
//             SizedBox(
//               width: 100,
//               height: 100,
//               child: _buildPieChart(double.parse(today), double.parse(target)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSalesCard(String customer, String pyYTD, String pyMTD, String cyYTD, String cyMTD) {
//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: ListTile(
//         title: Text(customer, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('P.Y YTD: $pyYTD'),
//             Text('P.Y MTD: $pyMTD'),
//             Text('C.Y YTD: $cyYTD'),
//             Text('C.Y MTD: $cyMTD'),
//             SizedBox(
//               width: 100,
//               height: 100,
//               child: _buildPieChart(double.parse(pyYTD), double.parse(cyYTD)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPieChart(double value1, double value2) {
//     return PieChart(
//       PieChartData(
//         sections: [
//           PieChartSectionData(
//             color: Colors.blueAccent,
//             value: value1,
//             title: '${value1.toString()}%',
//             radius: 50.0,
//           ),
//           PieChartSectionData(
//             color: Colors.greenAccent,
//             value: value2,
//             title: '${value2.toString()}%',
//             radius: 50.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
