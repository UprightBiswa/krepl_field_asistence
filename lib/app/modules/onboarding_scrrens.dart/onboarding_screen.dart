// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../data/constrants/constants.dart';
// import '../../model/onboarding/onboarding_list_model.dart';
// import '../auth/sign_in_page.dart';
// import '../widgets/widgets.dart';
// import 'components/next_button.dart';
// import 'components/onboarding_card.dart';
// import 'components/skip_button.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   OnboardingScreenState createState() => OnboardingScreenState();
// }

// class OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentPageIndex = 0;
//   final _pageController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode(BuildContext context) =>
//         Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       backgroundColor:
//           isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
//       appBar: AppBar(
//         backgroundColor:
//             isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
//         actions: [
//           SkipButton(
//             onTap: () {
//               Get.offAll(() => const SignIn());
//             },
//           ),
//           SizedBox(width: 16.w),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               child: PageView.builder(
//             itemCount: onboardingList.length,
//             controller: _pageController,
//             //  physics: const NeverScrollableScrollPhysics(),
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPageIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               return OnboardingCard(
//                 playAnimation: true,
//                 onboarding: onboardingList[index],
//               );
//             },
//           )),
//           SmoothPageIndicator(
//               controller: _pageController,
//               count: onboardingList.length,
//               effect: WormEffect(
//                   dotHeight: 8.h,
//                   dotWidth: 8.w,
//                   dotColor: AppColors.kPrimary.withOpacity(0.2)),
//               onDotClicked: (index) {
//                 setState(() {
//                   _currentPageIndex = index;
//                 });
//                 _pageController.animateToPage(
//                   index,
//                   duration: const Duration(milliseconds: 500),
//                   curve: Curves.easeInOut,
//                 );
//               }),
//           SizedBox(height: 30.h),
//           (_currentPageIndex < onboardingList.length - 1)
//               ? NextButton(onTap: () {
//                   _pageController.nextPage(
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.easeInOut,
//                   );
//                 })
//               : PrimaryButton(
//                   onTap: () {
//                     Get.offAll(() => const SignIn(),
//                         transition: Transition.zoom);
//                   },
//                   width: 166.w,
//                   text: 'Get Started',
//                 ),
//           SizedBox(height: 20.h),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/constrants/constants.dart';
import '../../model/onboarding/onboarding_list_model.dart';
import '../auth/sign_in_page.dart';
import '../widgets/widgets.dart';
import 'components/next_button.dart';
import 'components/onboarding_card.dart';
import 'components/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPageIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GradientBackground(isDarkMode: isDarkMode(context)),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  SkipButton(
                    onTap: () {
                      Get.offAll(() => const SignIn());
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
                  dotColor: AppColors.kPrimary.withOpacity(0.2),
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
                        Get.offAll(() => const SignIn(),
                            transition: Transition.zoom);
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
  final bool isDarkMode;

  const GradientBackground({Key? key, required this.isDarkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [AppColors.kDarkBackground, AppColors.kSecondary]
              : [AppColors.kGradientbottom, AppColors.kGradienttop],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
