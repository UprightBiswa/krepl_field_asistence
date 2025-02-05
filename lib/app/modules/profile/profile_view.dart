import 'package:field_asistence/app/modules/widgets/texts/custom_header_text.dart';
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
        title: Text(
          'Profile',
          style: AppTypography.kBold16.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkSurfaceColor,
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
            iconColor: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkSurfaceColor,
            color: AppColors.kWhite.withOpacity(0.15),
          ),
          SizedBox(width: AppSpacing.tenHorizontal),
        ],
      ),
      body: DefaultTabController(
        length: 4,
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
                      text: 'personal',
                    ),
                    Tab(
                      text: 'Contacts',
                    ),
                    Tab(
                      text: 'Work',
                    ),
                    Tab(
                      text: 'Mapping',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTabContent(context, 'Personal Information',
                        buildPersonalDetails(widget.userDetails)),
                    _buildTabContent(context, 'Contact Information',
                        buildContactDetails(widget.userDetails)),
                    _buildTabContent(context, 'Work Details',
                        buildWorkDetails(widget.userDetails)),
                    _buildTabContent(context, 'Mapping Information',
                        buildMappingDetails(widget.userDetails)),
                    // _buildTabContent(context, 'Reports and Activities',
                    //     buildReportsAndActivities(widget.userDetails)),
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
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
      ),
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
    return CustomHeaderText(
      text: title,
      fontSize: 16,
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
              '${userDetails.workplaceCode} - ${userDetails.workplaceName}\n'
              'Start Date: '
              '${userDetails.workplaceStartDate ?? 'dd-mm-yyyy'} \n'
              'End Date: '
              '${userDetails.workplaceEndDate ?? 'dd-mm-yyyy'} ',
        ),
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.location_city,
          title: 'HQ',
          subtitle: '${userDetails.headquarter}\n('
              ' Start Date: '
              '${userDetails.hqStartDate ?? 'dd-mm-yyyy'} - '
              'End Date: '
              '${userDetails.hqEndDate ?? 'dd-mm-yyyy'} )',
        ),
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.grade,
          title: 'Grade',
          subtitle: '${userDetails.grade ?? 'N/A'}\n('
              ' Start Date: '
              '${userDetails.gradeStartDate ?? 'dd-mm-yyyy'} - '
              'End Date: '
              '${userDetails.gradeEndDate ?? 'dd-mm-yyyy'} )',
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
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.group,
          title: 'Customer',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.villa,
          title: 'Village',
          subtitle:
              '${userDetails.hrEmployeeCode} (${userDetails.hrEmployeeCode})',
        ),
        const Divider(),
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
        const Divider(),
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
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.calendar_today,
          title: 'Date of Joining',
          subtitle: userDetails.dateOfJoining,
        ),
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.calendar_today,
          title: 'Date of Leaving',
          subtitle: userDetails.dateOfLeaving,
        ),
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.badge,
          title: 'Staff Type',
          subtitle: userDetails.staffType ?? 'None',
        ),
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.check_circle,
          title: 'Status',
          subtitle: userDetails.isActive ?? 'Active',
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
        const Divider(),
        buildAnimatedListTile(
          icon: Icons.flight,
          title: 'Tour Plan',
          subtitle: userDetails.hrEmployeeCode,
        ),
        const Divider(),
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
