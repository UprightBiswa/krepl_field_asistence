// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../data/constrants/constants.dart';
// import '../../model/login/user_details_reponse.dart';
// import '../home/components/custom_menu_card.dart';
// import '../widgets/buttons/buttons.dart';
// import '../widgets/containers/primary_container.dart';
// import 'components/profile_image_card.dart';
// import 'settings_view.dart';

// class ProfileView extends StatefulWidget {
//   final UserDetails userDetails;
//   const ProfileView({
//     super.key,
//     required this.userDetails,
//   });

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   bool isDarkMode(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kPrimary,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           CustomIconButton(
//             onTap: () {
//               Get.to<dynamic>(
//                   SettingsView(
//                     userDetails: widget.userDetails,
//                   ),
//                   transition: Transition.rightToLeftWithFade);
//             },
//             icon: AppAssets.kSetting,
//             iconColor: isDarkMode(context)
//                 ? AppColors.kWhite
//                 : AppColors.kDarkSurfaceColor,
//             color: AppColors.kWhite.withOpacity(0.15),
//           ),
//           SizedBox(width: AppSpacing.tenHorizontal),
//         ],
//       ),
//       body: ScrollConfiguration(
//         behavior: const ScrollBehavior().copyWith(overscroll: false),
//         child: SingleChildScrollView(
//           physics: const ClampingScrollPhysics(),
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: isDarkMode(context)
//                       ? AppColors.kDarkContiner
//                       : AppColors.kWhite,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(AppSpacing.radiusThirty),
//                   ),
//                 ),
//                 margin: EdgeInsets.only(top: 40.h),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 65.h),
//                     Text(
//                       widget.userDetails.employeeName,
//                       style: AppTypography.kBold20,
//                     ),
//                     Text(
//                       widget.userDetails.hrEmployeeCode,
//                       style: AppTypography.kLight14,
//                     ),
//                     SizedBox(height: 30.h),
//                     // Uncomment and modify this section if needed
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         CustomMenuCard(
//                           isSelected: false,
//                           icon: Icons.work,
//                           onTap: () {},
//                           title: 'Work',
//                         ),
//                         CustomMenuCard(
//                           isSelected: false,
//                           icon: Icons.map,
//                           onTap: () {},
//                           title: 'Mapping',
//                         ),
//                         CustomMenuCard(
//                           isSelected: false,
//                           icon: Icons.contact_phone,
//                           onTap: () {},
//                           title: 'Contact',
//                         ),
//                         CustomMenuCard(
//                           isSelected: false,
//                           icon: Icons.person,
//                           onTap: () {},
//                           title: 'Personal',
//                         ),
//                         CustomMenuCard(
//                           isSelected: false,
//                           icon: Icons.report,
//                           onTap: () {},
//                           title: 'Reports',
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: AppSpacing.thirtyVertical),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20.h),
//                       decoration: BoxDecoration(
//                         color: isDarkMode(context)
//                             ? AppColors.kPrimary.withOpacity(0.08)
//                             : AppColors.kPrimary.withOpacity(0.15),
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(AppSpacing.radiusThirty),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: AppSpacing.thirtyVertical),
//                           _buildDetailsContainer(
//                             context,
//                             'Work Details',
//                             buildWorkDetails(widget.userDetails),
//                           ),
//                           SizedBox(height: AppSpacing.thirtyVertical),
//                           _buildDetailsContainer(
//                             context,
//                             'Mapping Information',
//                             buildMappingDetails(widget.userDetails),
//                           ),
//                           SizedBox(height: AppSpacing.thirtyVertical),
//                           _buildDetailsContainer(
//                             context,
//                             'Contact Information',
//                             buildContactDetails(widget.userDetails),
//                           ),
//                           SizedBox(height: AppSpacing.thirtyVertical),
//                           _buildDetailsContainer(
//                             context,
//                             'Personal Information',
//                             buildPersonalDetails(widget.userDetails),
//                           ),
//                           SizedBox(height: AppSpacing.thirtyVertical),
//                           _buildDetailsContainer(
//                             context,
//                             'Reports and Activities',
//                             buildReportsAndActivities(widget.userDetails),
//                           ),
//                           SizedBox(height: AppSpacing.thirtyVertical),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const ProfileImageCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailsContainer(
//     BuildContext context,
//     String title,
//     Widget child,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildSectionTitle(title),
//         SizedBox(height: 10.h),
//         PrimaryContainer(
//           padding: EdgeInsets.symmetric(horizontal: 0.h),
//           child: child,
//         ),
//       ],
//     );
//   }

//   Widget buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: AppTypography.kBold16,
//     );
//   }

//   Widget buildWorkDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.work,
//           title: 'Work Place',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.location_city,
//           title: 'HQ',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.grade,
//           title: 'Grade',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//       ],
//     );
//   }

//   Widget buildMappingDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.terrain,
//           title: 'Territory',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.group,
//           title: 'Customer',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.villa,
//           title: 'Village',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.store,
//           title: 'Retailer',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//       ],
//     );
//   }

//   Widget buildContactDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.phone,
//           title: 'Mobile',
//           subtitle: userDetails.mobileNumber,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.email,
//           title: 'Email',
//           subtitle: userDetails.email,
//         ),
//       ],
//     );
//   }

//   Widget buildPersonalDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.person,
//           title: 'Father Name',
//           subtitle: userDetails.fatherName,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.calendar_today,
//           title: 'Date of Joining',
//           subtitle: userDetails.dateOfJoining,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.calendar_today,
//           title: 'Date of Leaving',
//           subtitle: userDetails.dateOfLeaving,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.badge,
//           title: 'Staff Type',
//           subtitle: userDetails.staffType,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.check_circle,
//           title: 'Status',
//           subtitle: "Active" "Inactive",
//         ),
//       ],
//     );
//   }

//   Widget buildReportsAndActivities(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.calendar_view_day,
//           title: 'Attendance',
//           subtitle: userDetails.hrEmployeeCode,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.flight,
//           title: 'Tour Plan',
//           subtitle: userDetails.hrEmployeeCode,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.flag,
//           title: 'Targets',
//           subtitle: userDetails.hrEmployeeCode,
//         ),
//       ],
//     );
//   }

//   Widget buildAnimatedListTile({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return ListTile(
//       leading: AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         decoration: BoxDecoration(
//           color: AppColors.kPrimary.withOpacity(0.1),
//           shape: BoxShape.circle,
//         ),
//         padding: const EdgeInsets.all(8.0),
//         child: Icon(
//           icon,
//           color: AppColors.kPrimary,
//         ),
//       ),
//       title: Text(
//         title,
//         style: AppTypography.kBold14,
//       ),
//       subtitle: Text(
//         subtitle,
//         style: AppTypography.kLight14,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/containers/primary_container.dart';
import 'components/profile_image_card.dart';
import 'settings_view.dart';

class ProfileView extends StatefulWidget {
  final UserDetails userDetails;
  const ProfileView({
    super.key,
    required this.userDetails,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode(context) ? AppColors.kDarkContiner : AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        elevation: 0,
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
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      color: AppColors.kPrimary,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: isDarkMode(context)
                                      ? AppColors.kDarkContiner
                                      : AppColors.kWhite,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                        AppSpacing.radiusThirty),
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 40.h),
                                child: Column(
                                  children: [
                                    SizedBox(height: 65.h),
                                    Text(
                                      widget.userDetails.employeeName,
                                      style: AppTypography.kBold20,
                                    ),
                                    Text(
                                      widget.userDetails.hrEmployeeCode,
                                      style: AppTypography.kLight14,
                                    ),
                                    SizedBox(height: 30.h),
                                  ],
                                ),
                              ),
                              const ProfileImageCard(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              Material(
                color: isDarkMode(context)
                    ? AppColors.kDarkContiner
                    : AppColors.kWhite,
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: AppColors.kPrimary,
                  labelStyle: AppTypography.kBold14,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: AppTypography.kBold12,
                  indicatorColor: AppColors.kPrimary,
                  tabs: const [
                    Tab(
                      text: 'Work',
                    ),
                    Tab(
                      text: 'Mapping',
                    ),
                    Tab(
                      text: 'Contacts',
                    ),
                    Tab(
                      text: 'personal',
                    ),
                    Tab(
                      text: 'Reports',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTabContent(context, 'Work Details',
                        buildWorkDetails(widget.userDetails)),
                    _buildTabContent(context, 'Mapping Information',
                        buildMappingDetails(widget.userDetails)),
                    _buildTabContent(context, 'Contact Information',
                        buildContactDetails(widget.userDetails)),
                    _buildTabContent(context, 'Personal Information',
                        buildPersonalDetails(widget.userDetails)),
                    _buildTabContent(context, 'Reports and Activities',
                        buildReportsAndActivities(widget.userDetails)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String title, Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode(context)
            ? AppColors.kPrimary.withOpacity(0.08)
            : AppColors.kPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusThirty),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.tenHorizontal),
            // Text(title, style: AppTypography.kBold20),
            // SizedBox(height: AppSpacing.twentyVertical),
            // content,
            _buildDetailsContainer(context, title, content),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsContainer(
    BuildContext context,
    String title,
    Widget child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle(title),
        SizedBox(height: 10.h),
        PrimaryContainer(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: child,
        ),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.kBold16,
    );
  }

  Widget buildWorkDetails(UserDetails userDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAnimatedListTile(
          icon: Icons.work,
          title: 'Work Place',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.location_city,
          title: 'HQ',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.grade,
          title: 'Grade',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
      ],
    );
  }

  Widget buildMappingDetails(UserDetails userDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAnimatedListTile(
          icon: Icons.terrain,
          title: 'Territory',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.group,
          title: 'Customer',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.villa,
          title: 'Village',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.store,
          title: 'Retailer',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
      ],
    );
  }

  Widget buildContactDetails(UserDetails userDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAnimatedListTile(
          icon: Icons.phone,
          title: 'Mobile',
          subtitle: userDetails.mobileNumber,
        ),
        buildAnimatedListTile(
          icon: Icons.email,
          title: 'Email',
          subtitle: userDetails.email,
        ),
      ],
    );
  }

  Widget buildPersonalDetails(UserDetails userDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAnimatedListTile(
          icon: Icons.person,
          title: 'Father Name',
          subtitle: userDetails.fatherName,
        ),
        buildAnimatedListTile(
          icon: Icons.calendar_today,
          title: 'Date of Joining',
          subtitle: userDetails.dateOfJoining,
        ),
        buildAnimatedListTile(
          icon: Icons.calendar_today,
          title: 'Date of Leaving',
          subtitle: userDetails.dateOfLeaving,
        ),
        buildAnimatedListTile(
          icon: Icons.badge,
          title: 'Staff Type',
          subtitle: userDetails.staffType,
        ),
        buildAnimatedListTile(
          icon: Icons.check_circle,
          title: 'Status',
          subtitle: "Active" "Inactive",
        ),
      ],
    );
  }

  Widget buildReportsAndActivities(UserDetails userDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAnimatedListTile(
          icon: Icons.calendar_view_day,
          title: 'Attendance',
          subtitle: userDetails.hrEmployeeCode,
        ),
        buildAnimatedListTile(
          icon: Icons.flight,
          title: 'Tour Plan',
          subtitle: userDetails.hrEmployeeCode,
        ),
        buildAnimatedListTile(
          icon: Icons.flag,
          title: 'Targets',
          subtitle: userDetails.hrEmployeeCode,
        ),
      ],
    );
  }

  Widget buildAnimatedListTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: AppColors.kPrimary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: AppColors.kPrimary,
        ),
      ),
      title: Text(
        title,
        style: AppTypography.kBold14,
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.kLight14,
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../data/constrants/constants.dart';
// import '../../model/login/user_details_reponse.dart';
// import '../widgets/buttons/buttons.dart';
// import '../widgets/containers/primary_container.dart';
// import 'components/profile_image_card.dart';
// import 'settings_view.dart';

// class ProfileView extends StatefulWidget {
//   final UserDetails userDetails;
//   const ProfileView({
//     super.key,
//     required this.userDetails,
//   });

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   bool isDarkMode(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark;

//   final ItemScrollController itemScrollController = ItemScrollController();
//   final ItemPositionsListener itemPositionsListener =
//       ItemPositionsListener.create();
//   late List<double> visibility;
//   int selectedTab = 0;
//   final DateTime ensureVisibleTime = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     visibility = List.generate(5, (index) => 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor:
//           isDarkMode(context) ? AppColors.kDarkContiner : AppColors.kWhite,
//       appBar: AppBar(
//         backgroundColor: AppColors.kPrimary,
//         elevation: 0,
//         actions: [
//           CustomIconButton(
//             onTap: () {
//               Get.to<dynamic>(
//                   SettingsView(
//                     userDetails: widget.userDetails,
//                   ),
//                   transition: Transition.rightToLeftWithFade);
//             },
//             icon: AppAssets.kSetting,
//             iconColor: isDarkMode(context)
//                 ? AppColors.kWhite
//                 : AppColors.kDarkSurfaceColor,
//             color: AppColors.kWhite.withOpacity(0.15),
//           ),
//           SizedBox(width: AppSpacing.tenHorizontal),
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildTabs(),
//           Expanded(
//             child: ScrollablePositionedList.builder(
//               itemCount: 5,
//               itemBuilder: (BuildContext context, int index) {
//                 return generateBlock(index, screenWidth,
//                     _buildTabContent(context, index, widget.userDetails));
//               },
//               itemScrollController: itemScrollController,
//               itemPositionsListener: itemPositionsListener,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabs() {
//     final List<String> tabTitles = [
//       'Work',
//       'Mapping',
//       'Contacts',
//       'Personal',
//       'Reports',
//     ];

//     return Container(
//       margin: const EdgeInsets.all(5),
//       height: 50.0,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: tabTitles.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               itemScrollController.scrollTo(
//                 index: index,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.ease,
//               );
//               setState(() {
//                 selectedTab = index;
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: selectedTab == index
//                     ? AppColors.kPrimary
//                     : AppColors.kWhite,
//               ),
//               child: Text(
//                 tabTitles[index],
//                 style: selectedTab == index
//                     ? AppTypography.kBold14
//                     : AppTypography.kLight14,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTabContent(
//       BuildContext context, int index, UserDetails userDetails) {
//     final List<String> titles = [
//       'Work Details',
//       'Mapping Information',
//       'Contact Information',
//       'Personal Information',
//       'Reports and Activities',
//     ];
//     final List<Widget> contents = [
//       buildWorkDetails(userDetails),
//       buildMappingDetails(userDetails),
//       buildContactDetails(userDetails),
//       buildPersonalDetails(userDetails),
//       buildReportsAndActivities(userDetails),
//     ];

//     return _buildDetailsContainer(context, titles[index], contents[index]);
//   }

//   Widget generateBlock(int index, double screenWidth, Widget targetWidget) {
//     return VisibilityDetector(
//       key: Key('block$index'),
//       onVisibilityChanged: (visibilityInfo) {
//         final visiblePercentage = visibilityInfo.visibleFraction * 100;
//         visibility[index] = visiblePercentage;
//         final int currentIndex = lastVisibleIndex(visibility);

//         if (currentIndex >= 0 && selectedTab != currentIndex) {
//           setState(() {
//             selectedTab = currentIndex;
//           });
//         }
//       },
//       child: targetWidget,
//     );
//   }

//   static int lastVisibleIndex(List<double> visibility) {
//     if (visibility[0] > 0) return 0;
//     if (visibility[visibility.length - 1] > 0) return visibility.length - 1;
//     for (int i = 1; i < visibility.length - 1; i++) {
//       if (visibility[i] > 0) return i;
//     }
//     return -1;
//   }

//   Widget _buildDetailsContainer(
//     BuildContext context,
//     String title,
//     Widget child,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isDarkMode(context)
//             ? AppColors.kPrimary.withOpacity(0.08)
//             : AppColors.kPrimary.withOpacity(0.15),
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(AppSpacing.radiusThirty),
//         ),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildSectionTitle(title),
//           SizedBox(height: 10.h),
//           PrimaryContainer(
//             padding: EdgeInsets.symmetric(horizontal: 0.h),
//             child: child,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: AppTypography.kBold16,
//     );
//   }

//   Widget buildWorkDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.work,
//           title: 'Work Place',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.location_city,
//           title: 'HQ',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.grade,
//           title: 'Grade',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//       ],
//     );
//   }

//   Widget buildMappingDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.terrain,
//           title: 'Territory',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.group,
//           title: 'Customer',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.villa,
//           title: 'Village',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//         buildAnimatedListTile(
//           icon: Icons.store,
//           title: 'Retailer',
//           subtitle:
//               '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
//         ),
//       ],
//     );
//   }

//   Widget buildContactDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.phone,
//           title: 'Mobile',
//           subtitle: userDetails.mobileNumber,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.email,
//           title: 'Email',
//           subtitle: userDetails.email,
//         ),
//       ],
//     );
//   }

//   Widget buildPersonalDetails(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.person,
//           title: 'Father Name',
//           subtitle: userDetails.fatherName,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.calendar_today,
//           title: 'Date of Joining',
//           subtitle: userDetails.dateOfJoining,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.calendar_today,
//           title: 'Date of Leaving',
//           subtitle: userDetails.dateOfLeaving,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.badge,
//           title: 'Staff Type',
//           subtitle: userDetails.staffType,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.check_circle,
//           title: 'Status',
//           subtitle: "Active" "Inactive",
//         ),
//       ],
//     );
//   }

//   Widget buildReportsAndActivities(UserDetails userDetails) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildAnimatedListTile(
//           icon: Icons.calendar_view_day,
//           title: 'Attendance',
//           subtitle: userDetails.hrEmployeeCode,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.flight,
//           title: 'Tour Plan',
//           subtitle: userDetails.hrEmployeeCode,
//         ),
//         buildAnimatedListTile(
//           icon: Icons.flag,
//           title: 'Targets',
//           subtitle: userDetails.hrEmployeeCode,
//         ),
//       ],
//     );
//   }

//   Widget buildAnimatedListTile({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return ListTile(
//       leading: AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         decoration: BoxDecoration(
//           color: AppColors.kPrimary.withOpacity(0.1),
//           shape: BoxShape.circle,
//         ),
//         padding: const EdgeInsets.all(8.0),
//         child: Icon(
//           icon,
//           color: AppColors.kPrimary,
//         ),
//       ),
//       title: Text(
//         title,
//         style: AppTypography.kBold14,
//       ),
//       subtitle: Text(
//         subtitle,
//         style: AppTypography.kLight14,
//       ),
//     );
//   }
// }
