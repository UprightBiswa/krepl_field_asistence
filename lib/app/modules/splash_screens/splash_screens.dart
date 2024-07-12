// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../provider/connction_provider/connectivity_provider.dart';
import '../../provider/login_provider/login_provider.dart';
import '../../repository/auth/auth_token.dart';
import '../auth/sign_in_page.dart';
import '../landing_screens/landing_page.dart';
import '../navigation/navigation_home_screen.dart';
import '../onboarding_scrrens.dart/onboarding_screen.dart';
import 'components/place_holder_dialog.dart';
import 'controller/app_info_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

void showToast(String message, BuildContext context) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  // final AppInfoProvider _newAppinfoProvider = AppInfoProvider();
  String appVersion = "";
  late LoginProvider loginProvider;
  UserDetails? userDetails;
  late ConnectivityProvider connectivityProvider;
  final AppInfoController _appInfoController = Get.put(AppInfoController());

  @override
  void initState() {
    super.initState();
    connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    getUserInfo();
    getAppVersion();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _logoAnimation = Tween<double>(begin: -50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward().whenComplete(
      () async {
        bool isFirstLaunch = await checkFirstLaunch();
        if (isFirstLaunch) {
          Navigator.pushReplacement(
            // ignore: duplicate_ignore
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        } else {
          //navigateBasedOnLoginStatus();
          // if (!connectivityProvider.isConnected) {
            navigateBasedOnLoginStatus();
          //   return;
          // } else {
          //   fetchAppInfo();
          // }
        }
      },
    ).catchError((error) {
      print('Error checking first launch: $error');
      // Handle error if necessary
    });
  }

  Future<void> getUserInfo() async {
    try {
      //  if (!connectivityProvider.isConnected) {
      //   navigateBasedOnLoginStatus(); // Navigate to home page
      //   return;
      // }
      String? userCode = await AuthState().getEmployeeCode();

      if (mounted) {
        if (userCode != null && userCode.isNotEmpty) {
          setState(() async {
            userDetails = await fetchUserDetails(userCode);
          });
          if (kDebugMode) {
            print('details: $userDetails');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      setState(() {
        userDetails = null;
      });
    }
  }

  Future<UserDetails?> fetchUserDetails(String userCode) async {
    try {
      // await loginProvider.getUserInfo(userCode, context);

      // // Return the fetched UserDetails object
      // return loginProvider.userDetails;
      UserDetailsResponse response =
          await loginProvider.getUserInfo(userCode, context);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user details: $e');
      }
      return null;
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
      if (kDebugMode) {
        print('app version: $appVersion');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting app version: $e');
      }
      setState(() {
        appVersion = '';
      });
    }
  }

  void fetchAppInfo() async {
    try {
      await _appInfoController.getAppInfo(context: context);
      final appInfo = _appInfoController.appInfoResponse.value;
      if (appInfo != null) {
        if (appInfo.appVersion != appVersion) {
          showUpgradeDialog(appInfo.appLink, appInfo.priority);
        } else {
          navigateBasedOnLoginStatus();
        }
      } else {
        showToast('Failed to fetch app info', context);
      }
    } catch (e) {
      if (e.toString().contains('No internet connection')) {
        showNoInternetDialog();
      } else {
        showToast('Error fetching app info', context);
      }
      print('Exception fetching: $e');
    }
  }

  void showUpgradeDialog(String appLink, String priority) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PlaceholderDialog(
          image: Image.asset(
            AppAssets.kLogo,
            // 'assets/images/logo.png',
            width: 80,
            height: 80,
          ),
          title: 'Upgrade Required',
          message: 'A new version of the app is available.',
          actions: [
            TextButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(appLink))) {
                  await launchUrl(Uri.parse(appLink));
                } else {
                  await launchUrl(Uri.parse(appLink));
                  print('Could not launch $appLink');
                }
              },
              child: const Text('Upgrade Now'),
            ),
            if (priority == '0')
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  navigateBasedOnLoginStatus();
                },
                child: const Text('Cancel'),
              ),
          ],
        );
      },
    );
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.red),
              SizedBox(width: 10),
              Text(
                'No Internet Connection',
                style: TextStyle(
                    color: AppColors.kAccent7,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
              'Please turn on your internet connection to continue.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Reload'),
              onPressed: () {
                Navigator.of(context).pop();
                //fetchAppInfo();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateBasedOnLoginStatus() async {
    bool isLoggedIn =
        (await Provider.of<AuthState>(context, listen: false).getEmployeeCode())
                ?.isNotEmpty ??
            false;
    if (userDetails != null && isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // builder: (context) => LandingPage(userDetails: userDetails!),
          builder: (context) => NavigationHomeScreen(userDetails: userDetails!),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }

  Future<bool> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
    if (isFirstLaunch) {
      prefs.setBool('firstLaunch', false);
    }
    return isFirstLaunch;
  }

// Initialize the provider here
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    connectivityProvider = Provider.of<ConnectivityProvider>(context);
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
      appBar: AppBar(
        backgroundColor:
            isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(0, _logoAnimation.value),
                        child: Image.asset(
                          AppAssets.kLogo,
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
           
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode(context)
              ? AppColors.kDarkBackground
              : AppColors.kWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Powered by:', style: AppTypography.kMedium14),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/indigi.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
