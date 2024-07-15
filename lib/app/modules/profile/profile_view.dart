// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../data/constrants/constants.dart';
// import '../../model/home/course.dart';
// import '../../model/login/user_details_reponse.dart';
// import '../home/components/course_card.dart';
// import '../home/components/custom_menu_card.dart';
// import '../widgets/buttons/buttons.dart';
// import 'components/profile_image_card.dart';
// import 'settings_view.dart';

// class ProfileView extends StatelessWidget {
//   final UserDetails userDetails;
//   const ProfileView({
//     super.key,
//     required this.userDetails,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode(BuildContext context) =>
//         Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor:
//           isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kPrimary,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         actions: [
//           CustomIconButton(
//             onTap: () {
//               Get.to<dynamic>(
//                   SettingsView(
//                     userDetails: userDetails,
//                   ),
//                   transition: Transition.rightToLeftWithFade);
//             },
//             icon: AppAssets.kMoreVert,
//             iconColor: AppColors.kWhite,
//             color: AppColors.kWhite.withOpacity(0.15),
//           ),
//           SizedBox(width: AppSpacing.twentyHorizontal),
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
//                       ? AppColors.kSecondary
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
//                       userDetails.employeeName,
//                       style: AppTypography.kBold20,
//                     ),
//                     Text(
//                       userDetails.employeeCode,
//                       style: AppTypography.kLight14,
//                     ),
//                     SizedBox(height: 30.h),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //   children: [
//                     //     CustomMenuCard(
//                     //       isSelected: false,
//                     //       icon: AppAssets.kFollow,
//                     //       onTap: () {},
//                     //       title: 'Follow',
//                     //     ),
//                     //     CustomMenuCard(
//                     //       isSelected: false,
//                     //       icon: AppAssets.kMessage,
//                     //       onTap: () {
//                     //         // Get.to<dynamic>(() => const MessageView());
//                     //       },
//                     //       title: 'Message',
//                     //     ),
//                     //     CustomMenuCard(
//                     //       isSelected: false,
//                     //       icon: AppAssets.kLinks,
//                     //       onTap: () {},
//                     //       title: 'Links',
//                     //     ),
//                     //   ],
//                     // ),
//                     // SizedBox(height: AppSpacing.thirtyVertical),
//                     // Container(
//                     //   padding: EdgeInsets.symmetric(horizontal: 20.h),
//                     //   decoration: BoxDecoration(
//                     //     color: isDarkMode(context)
//                     //         ? AppColors.kPrimary.withOpacity(0.08)
//                     //         : AppColors.kPrimary.withOpacity(0.15),
//                     //     borderRadius: BorderRadius.vertical(
//                     //       top: Radius.circular(AppSpacing.radiusThirty),
//                     //     ),
//                     //   ),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       SizedBox(height: AppSpacing.thirtyVertical),
//                     //       Text(
//                     //         'About',
//                     //         style: AppTypography.kBold14,
//                     //       ),
//                     //       Text(
//                     //         'I’m a web design enthusiast. I love\nteaching and creating experiences that\nadd value to people’s lives. ',
//                     //         style: AppTypography.kLight14,
//                     //       ),
//                     //       SizedBox(height: AppSpacing.fortyVertical),
//                     //       Row(
//                     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //         children: [
//                     //           Text(
//                     //             'Featured Courses',
//                     //             style: AppTypography.kBold14,
//                     //           ),
//                     //           CustomTextButton(
//                     //               onPressed: () {}, text: 'See All'),
//                     //         ],
//                     //       ),
//                     //       SizedBox(height: 10.h),
//                     //       SizedBox(
//                     //         height: 280.h,
//                     //         child: ListView.separated(
//                     //           clipBehavior: Clip.none,
//                     //           separatorBuilder: (context, index) => SizedBox(
//                     //             width: 30.w,
//                     //           ),
//                     //           scrollDirection: Axis.horizontal,
//                     //           itemCount: coursesList.length,
//                     //           itemBuilder: (context, index) {
//                     //             return CourseCard(
//                     //               course: coursesList[index],
//                     //             );
//                     //           },
//                     //         ),
//                     //       ),
//                     //       SizedBox(height: 90.h),
//                     //     ],
//                     //   ),
//                     // ),
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
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../home/components/custom_menu_card.dart';
import '../widgets/buttons/buttons.dart';
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
          isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
            iconColor: AppColors.kWhite,
            color: AppColors.kWhite.withOpacity(0.15),
          ),
          SizedBox(width: AppSpacing.twentyHorizontal),
        ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode(context)
                      ? AppColors.kSecondary
                      : AppColors.kWhite,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.radiusThirty),
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
                      widget.userDetails.employeeCode,
                      style: AppTypography.kLight14,
                    ),
                    SizedBox(height: 30.h),
                    // Uncomment and modify this section if needed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomMenuCard(
                          isSelected: false,
                          icon: Icons.work,
                          onTap: () {},
                          title: 'Work',
                        ),
                        CustomMenuCard(
                          isSelected: false,
                          icon: Icons.map,
                          onTap: () {},
                          title: 'Mapping',
                        ),
                        CustomMenuCard(
                          isSelected: false,
                          icon: Icons.contact_phone,
                          onTap: () {},
                          title: 'Contact',
                        ),
                        CustomMenuCard(
                          isSelected: false,
                          icon: Icons.person,
                          onTap: () {},
                          title: 'Personal',
                        ),
                        CustomMenuCard(
                          isSelected: false,
                          icon: Icons.report,
                          onTap: () {},
                          title: 'Reports',
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.thirtyVertical),
                    _buildDetailsContainer(
                      context,
                      'Work Details',
                      Column(
                        children: [
                          buildWorkDetails(widget.userDetails),
                          _buildDetailsContainer(
                            context,
                            'Mapping Information',
                            Column(
                              children: [
                                buildMappingDetails(widget.userDetails),
                                _buildDetailsContainer(
                                  context,
                                  'Contact Information',
                                  Column(
                                    children: [
                                      buildContactDetails(widget.userDetails),
                                      _buildDetailsContainer(
                                        context,
                                        'Personal Information',
                                        Column(
                                          children: [
                                            buildPersonalDetails(
                                                widget.userDetails),
                                            _buildDetailsContainer(
                                              context,
                                              'Reports and Activities',
                                              buildReportsAndActivities(
                                                  widget.userDetails),
                                              isDarkMode(context)
                                                  ? AppColors.kPrimary
                                                      .withOpacity(0.1)
                                                  : AppColors.kPrimary
                                                      .withOpacity(0.2),
                                            ),
                                          ],
                                        ),
                                        isDarkMode(context)
                                            ? AppColors.kPrimary
                                                .withOpacity(0.14)
                                            : AppColors.kPrimary
                                                .withOpacity(0.22),
                                      ),
                                    ],
                                  ),
                                  isDarkMode(context)
                                      ? AppColors.kPrimary.withOpacity(0.12)
                                      : AppColors.kPrimary.withOpacity(0.18),
                                ),
                              ],
                            ),
                            isDarkMode(context)
                                ? AppColors.kPrimary.withOpacity(0.08)
                                : AppColors.kPrimary.withOpacity(0.15),
                          ),
                        ],
                      ),
                      isDarkMode(context)
                          ? AppColors.kPrimary.withOpacity(0.1)
                          : AppColors.kPrimary.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
              const ProfileImageCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsContainer(
    BuildContext context,
    String title,
    Widget child,
    Color containerColor,
  ) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20.h),
      decoration: BoxDecoration(
        // color: Theme.of(context).brightness == Brightness.dark
        //     ? AppColors.kPrimary.withOpacity(0.08)
        //     : AppColors.kPrimary.withOpacity(0.15),
        color: containerColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusThirty),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.thirtyVertical),
          buildSectionTitle(title),
          child,
          // SizedBox(height: AppSpacing.thirtyVertical),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Text(
        title,
        style: AppTypography.kBold14,
      ),
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
              '${userDetails.workPlaceName} (${userDetails.workPlaceCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.location_city,
          title: 'HQ',
          subtitle: '${userDetails.hqName} (${userDetails.hqCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.grade,
          title: 'Grade',
          subtitle: '${userDetails.gradeName} (${userDetails.gradeCode})',
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
              '${userDetails.territoryName} (${userDetails.territoryCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.group,
          title: 'Customer',
          subtitle: '${userDetails.customerName} (${userDetails.customerCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.villa,
          title: 'Village',
          subtitle: '${userDetails.villageName} (${userDetails.villageCode})',
        ),
        buildAnimatedListTile(
          icon: Icons.store,
          title: 'Retailer',
          subtitle: '${userDetails.retailerName} (${userDetails.retailerCode})',
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
          subtitle: '${userDetails.mobileNumber}',
        ),
        buildAnimatedListTile(
          icon: Icons.email,
          title: 'Email',
          subtitle: '${userDetails.emailAddress}',
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
          subtitle: '${userDetails.fatherName}',
        ),
        buildAnimatedListTile(
          icon: Icons.calendar_today,
          title: 'Date of Joining',
          subtitle: '${userDetails.dateOfJoining}',
        ),
        buildAnimatedListTile(
          icon: Icons.calendar_today,
          title: 'Date of Leaving',
          subtitle: '${userDetails.dateOfLeaving}',
        ),
        buildAnimatedListTile(
          icon: Icons.badge,
          title: 'Staff Type',
          subtitle: '${userDetails.staffType}',
        ),
        buildAnimatedListTile(
          icon: Icons.check_circle,
          title: 'Status',
          subtitle: '${userDetails.isActive ? "Active" : "Inactive"}',
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
          subtitle: '${userDetails.attendanceRecords}',
        ),
        buildAnimatedListTile(
          icon: Icons.flight,
          title: 'Tour Plan',
          subtitle: '${userDetails.tourPlan}',
        ),
        buildAnimatedListTile(
          icon: Icons.flag,
          title: 'Targets',
          subtitle: '${userDetails.targetAchievements}',
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
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: AppColors.kPrimary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(8.0),
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
