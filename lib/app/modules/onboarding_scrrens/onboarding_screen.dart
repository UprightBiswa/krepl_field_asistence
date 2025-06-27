import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../model/onboarding/onboarding_list_model.dart';
import '../../provider/login_provider/login_provider.dart';
import '../../repository/auth/auth_token.dart';
import '../attendance/controller/loaction_service.dart';
import '../auth/sign_in_page.dart';
import '../navigation/navigation_home_screen.dart';
import '../widgets/widgets.dart';
import 'components/next_button.dart';
import 'components/onboarding_card.dart';
import 'components/skip_button.dart';
import 'location_permission_disclosure.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPageIndex = 0;
  final _pageController = PageController();
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

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GradientBackground(),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  SkipButton(
                    onTap: () {
                      _navigateAfterChecks(context, loginProvider);
                    },
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: onboardingList.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingCard(
                      playAnimation: true,
                      onboarding: onboardingList[index],
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: onboardingList.length,
                effect: WormEffect(
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  dotColor: AppColors.kPrimary.withValues(alpha: 0.2),
                ),
                onDotClicked: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              SizedBox(height: 30.h),
              (_currentPageIndex < onboardingList.length - 1)
                  ? NextButton(onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    })
                  : PrimaryButton(
                      onTap: () {
                        _navigateAfterChecks(context, loginProvider);
                      },
                      width: 166.w,
                      text: 'Get Started',
                    ),
              SizedBox(height: 20.h),
            ],
          ),
        ],
      ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.kGradientbottom, AppColors.kGradienttop],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
