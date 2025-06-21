import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../repository/auth/auth_token.dart';
import '../dashboard/dashboard_page.dart';
import '../farmer/controller/farmer_controller.dart';
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
    Get.put(FarmerController());
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
            return false; 
          } else {
            return true; 
          }
        } else {
          setState(() {
            _currentIndex = 0;
          });
          return false; 
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: _widgetOptions[_currentIndex],
        bottomNavigationBar: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              if (!isDarkMode(context))
                BoxShadow(
                  color: AppColors.kPrimary.withValues(alpha: .2),
                  blurRadius: 7,
                  offset: const Offset(0, -5),
                )
              else
                BoxShadow(
                  color: AppColors.kDarkContiner.withValues(alpha:0.2),
                  blurRadius: 7,
                  offset: const Offset(0, -5),
                ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.kWhite,
            selectedLabelStyle: const TextStyle(
              color: AppColors.kWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            items: const [
              BottomNavigationBarItem(
                label: 'Dashboard',
                tooltip: 'Dashboard',
                icon: Icon(
                  AppAssets.kDashboardOutlied,
                  size: 24,
                  color: AppColors.kBlack,
                ),
                activeIcon: Icon(
                  AppAssets.kDashboard,
                  size: 24,
                  color: AppColors.kWhite,
                ),
                backgroundColor: AppColors.kWhite,
              ),
              BottomNavigationBarItem(
                label: 'Home',
                tooltip: 'Home',
                icon: Icon(
                  AppAssets.kHomeOutlined,
                  size: 24,
                  color: AppColors.kBlack,
                ),
                activeIcon: Icon(
                  AppAssets.kHome,
                  size: 24,
                  color: AppColors.kWhite,
                ),
                backgroundColor: AppColors.kWhite,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  AppAssets.kPersionOutliend,
                  size: 24,
                  color: AppColors.kBlack,
                ),
                label: 'Profile',
                tooltip: 'Profile',
                activeIcon: Icon(
                  AppAssets.kPersion,
                  size: 24,
                  color: AppColors.kWhite,
                ),
                backgroundColor: AppColors.kWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
