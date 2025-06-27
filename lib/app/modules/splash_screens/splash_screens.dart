import 'package:field_asistence/app/data/constrants/constants.dart';
import 'package:field_asistence/app/modules/onboarding_scrrens/location_permission_disclosure.dart';
import 'package:field_asistence/app/modules/onboarding_scrrens/onboarding_screen.dart';
import 'package:field_asistence/app/repository/auth/auth_token.dart';
import 'package:field_asistence/app/repository/firebase/firebase_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/login/user_details_reponse.dart';
import '../../provider/login_provider/login_provider.dart';
import '../attendance/controller/loaction_service.dart';
import '../auth/sign_in_page.dart';
import '../navigation/navigation_home_screen.dart';
import 'components/place_holder_dialog.dart';
import 'controller/app_info_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _handleStartupLogic(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final appInfoController = Get.put(AppInfoController());

    await FirebaseApi().initNotifications();

    // 1. Check onboarding
    if (await _checkFirstLaunch()) {
      Get.offAll(() => const OnboardingScreen());
      return;
    }

    // 2. Check app version
    String appVersion = "";
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
    } catch (_) {}

    try {
      await appInfoController.getAppInfo();
      final appInfo = appInfoController.appInfoResponse.value;

      if (appInfo != null && appInfo.appVersion != appVersion) {
        _showUpgradeDialog(
          context,
          appInfo.appLink,
          appInfo.priority,
          () => _navigateAfterChecks(context, loginProvider),
        );
      } else {
        _navigateAfterChecks(context, loginProvider);
      }
    } catch (e) {
      if (kDebugMode) print('App Info Error: $e');
      _navigateAfterChecks(context, loginProvider);
    }
  }

  Future<bool> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirst = prefs.getBool('firstLaunch') ?? true;
    if (isFirst) prefs.setBool('firstLaunch', false);
    return isFirst;
  }

  Future<void> _navigateAfterChecks(
      BuildContext context, LoginProvider loginProvider) async {
    // 3. Check location permission
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Show disclosure screen if permission is not granted
      Get.offAll(() => const LocationPermissionDisclosure(
            isLoggedIn: false,
            userDetails: null,
          ));
      return;
    }

    // 4. If location permission granted, check login status
    final token =
        await Provider.of<AuthState>(context, listen: false).getDeviceToken();
    final isLoggedIn = token != null && token.isNotEmpty;

    UserDetails? userDetails;

    if (isLoggedIn) {
      try {
        final response = await loginProvider.getUserInfo(token, context);
        userDetails = response.data;
      } catch (_) {
        if (kDebugMode) print("User info fetch failed.");
      }
    }

    if (isLoggedIn && userDetails != null) {
      await BackgroundService.initialize();
      Get.offAll(() => NavigationHomeScreen(userDetails: userDetails!));
    } else {
      Get.offAll(() => const SignIn());
    }
  }

  void _showUpgradeDialog(BuildContext context, String appLink, String priority,
      VoidCallback onCancel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PlaceholderDialog(
        image: Image.asset(AppAssets.kLogo, width: 80, height: 80),
        title: 'Upgrade Required',
        message: 'A new version of the app is available.',
        actions: [
          TextButton(
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse(appLink))) {
                await launchUrl(Uri.parse(appLink));
              } else {
                print('Could not launch $appLink');
              }
            },
            child: const Text('Upgrade Now'),
          ),
          if (priority == '0')
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel();
              },
              child: const Text('Cancel'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      _handleStartupLogic(context);
    });

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Center(
        child: Image.asset(AppAssets.kLogo, width: 180, height: 180),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: AppColors.kWhite),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Powered by:', style: AppTypography.kMedium14),
            const SizedBox(width: 8),
            Image.asset('assets/images/indigi.png', width: 50, height: 50),
          ],
        ),
      ),
    );
  }
}
