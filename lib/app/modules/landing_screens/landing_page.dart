import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../repository/auth/auth_token.dart';
import '../dashboard/dashboard_page.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';

class LandingPage extends StatefulWidget {
  final UserDetails? userDetails;
  final int? pageIndex;
  const LandingPage({
    super.key,
    this.userDetails,
    this.pageIndex,
  });

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthState authState = AuthState();
  late int _currentIndex;
  DateTime? currentBackPressTime;
  UserDetails? userDetails;
  late String? username;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageIndex ?? 0;
    userDetails = widget.userDetails;
    _widgetOptions = [
      DashboardPage(userDetails: userDetails!),
      HomeView(userDetails: userDetails!),
      ProfileView(userDetails: userDetails!),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
              ),
            );
            return false; // Prevent the app from exiting
          } else {
            return true; // Allow the app to exit
          }
        } else {
          setState(() {
            _currentIndex = 0;
          });
          return false; // Prevent the app from exiting
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: _widgetOptions[_currentIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(8.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              selectedLabelStyle: const TextStyle(
                color: AppColors.kWhite,
              ),
              unselectedLabelStyle: const TextStyle(
                color: AppColors.kGrey,
              ),
              selectedFontSize: 14.sp,
              unselectedFontSize: 12.sp,
              items: const [
                BottomNavigationBarItem(
                  label: 'Dashboard',
                  tooltip: 'Dashboard',
                  icon: Icon(
                    AppAssets.kDashboardOutlied,
                    size: 24,
                    color: AppColors.kGrey,
                  ),
                  activeIcon: Icon(
                    AppAssets.kDashboard,
                    size: 24,
                    color: AppColors.kWhite,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Home',
                  tooltip: 'Home',
                  icon: Icon(
                    AppAssets.kHomeOutlined,
                    size: 24,
                    color: AppColors.kGrey,
                  ),
                  activeIcon: Icon(
                    AppAssets.kHome,
                    size: 24,
                    color: AppColors.kWhite,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    AppAssets.kPersionOutliend,
                    size: 24,
                    color: AppColors.kGrey,
                  ),
                  label: 'Profile',
                  tooltip: 'Profile',
                  activeIcon: Icon(
                    AppAssets.kPersion,
                    size: 24,
                    color: AppColors.kWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
