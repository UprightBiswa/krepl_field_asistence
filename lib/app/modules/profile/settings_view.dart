import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/theme_controller.dart';
import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../repository/auth/auth_token.dart';
import '../auth/sign_in_page.dart';
import '../widgets/buttons/buttons.dart';
import 'components/app_version.dart';
import 'components/setting_tile.dart';

class SettingsView extends StatefulWidget {
  final UserDetails userDetails;
  const SettingsView({
    super.key,
    required this.userDetails,
  });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // bool isNotification = true;
  // bool isDownloadAll = true;
  String appVersion = "";
  bool loading = true;
  String appName = '';
  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _getAppName();
  }

  Future<void> _getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
    });
  }

  _loadInitialData() async {
    try {
      if (mounted) {
        await Future.wait([
          getAppVersion(),
        ]);
        setState(() {
          loading = false;
        });
      }
    } catch (error) {
      // Handle errors appropriately
      // ...
    }
  }

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          appVersion = packageInfo.version;
        });
      }
    } catch (e) {
      setState(() {
        appVersion = 'Unknown';
      });
    }
  }

  Future<void> _logout() async {
    bool confirmLogout = await _showLogoutConfirmationDialog();
    if (confirmLogout) {
      AuthState().clearToken();

      Get.offAll(() => const SignIn());
    }
  }

  Future<bool> _showLogoutConfirmationDialog() async {
    bool? result = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning,
                size: 48,
                color: Colors.orange,
              ),
              SizedBox(height: 16.h),
              Text(
                'Confirm Logout',
                style: AppTypography.kBold24.copyWith(
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Do you really want to log out',
                textAlign: TextAlign.center,
                style: AppTypography.kMedium12.copyWith(
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onTap: () => Navigator.of(context).pop(false),
                      text: 'No',
                      // isBorder: true,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: PrimaryButton(
                      onTap: () => Navigator.of(context).pop(true),
                      text: 'Yes',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return result ?? false;
  }

  void launchurlprivacypolicy(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? _buildLoadingIndicator() : _buildSettingsPage();
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildSettingsPage() {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10.h),
          child: CustomIconButton(
            color: isDarkMode(context)
                ? Colors.black
                : AppColors.kPrimary.withOpacity(0.14),
            icon: AppAssets.kArrowBack,
            iconColor: isDarkMode(context) ? Colors.white : AppColors.kPrimary,
            onTap: () {
              Get.back<void>();
            },
          ),
        ),
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SettingTile(
                    icon: AppAssets.kProfile,
                    title: widget.userDetails.employeeName,
                    subtitle: widget.userDetails.hrEmployeeCode,
                    onTap: () {},
                  ),
                  const Divider(height: 0.5),
                  SettingTile(
                    icon: AppAssets.kEmail,
                    title: 'Email',
                    subtitle: widget.userDetails.email,
                    onTap: () {},
                  ),
                  const Divider(height: 0.5),
                  // SettingTile(
                  //   icon: AppAssets.kPassword,
                  //   title: 'Password',
                  //   subtitle: 'Last changed 3 months ago',
                  //   onTap: () {},
                  // ),
                  // const Divider(),
                  // SettingTile(
                  //   icon: AppAssets.kNotifications,
                  //   isSwitch: true,
                  //   title: 'Notifications',
                  //   switchValue: isNotification,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isNotification = value;
                  //     });
                  //   },
                  // ),
                  // const Divider(),
                  GetBuilder<ThemeController>(
                    init: ThemeController(),
                    initState: (_) {},
                    builder: (_) {
                      final isLightMode = _.theme == 'light';
                      return SettingTile(
                        icon: AppAssets.kTheme,
                        isSwitch: true,
                        title: 'Light Mode',
                        switchValue: isLightMode,
                        onChanged: (value) {
                          if (isLightMode) {
                            _.setTheme('dark');
                          } else {
                            _.setTheme('light');
                          }
                        },
                      );
                    },
                  ),
                  // const Divider(),
                  // SettingTile(
                  //   icon: AppAssets.kDownload,
                  //   isSwitch: true,
                  //   title: 'Download courses',
                  //   switchValue: isDownloadAll,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isDownloadAll = value;
                  //     });
                  //   },
                  // ),
                  // const Divider(),
                  // SettingTile(
                  //   icon: AppAssets.kHelp,
                  //   title: 'Help & Feedback',
                  //   onTap: () {},
                  // ),
                  const Divider(),
                  SettingTile(
                    icon: AppAssets.kPrivacy,
                    title: "Privacy Policy",
                    onTap: () {
                      launchurlprivacypolicy(
                          'https://krepl.indigidigital.in/krepl_privacy_policy.html');
                    },
                  ),
                  const Divider(),
                  SettingTile(
                    icon: Icons.info,
                    title: "App Version",
                    // subtitle: appVersion,
                    onTap: () {},
                    trailing: const AppVersionWidget(),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(
              onTap: () {
                _logout();
              },
              text: 'Sign Out',
            ),
          ),
        ],
      ),
    );
  }
}
