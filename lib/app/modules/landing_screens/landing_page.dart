import 'package:flutter/material.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../repository/auth/auth_token.dart';
import '../dashboard/dashboard_table_view.dart';
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
    print('Landing Page Index: $_currentIndex');
    userDetails = widget.userDetails;
    // Initialize _widgetOptions here
    _widgetOptions = [
      DashboardTableView(userDetails: userDetails!),
      HomeView(userDetails: userDetails!),
      ProfileView(userDetails: userDetails!),
      // BookingsView(userDetails: userDetails!),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      print('Current Index after onItemTapped: $_currentIndex');
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
    print('Landing Page Index in build: $_currentIndex');

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
        bottomNavigationBar: NavigationBar(
          elevation: 2,
          height: 60,
          animationDuration: const Duration(milliseconds: 500),
          backgroundColor: AppColors.kPrimary.withOpacity(0),
          selectedIndex: _currentIndex,
          onDestinationSelected: _onItemTapped,
          indicatorColor: AppColors.kPrimary.withOpacity(0.2),
          destinations: const <Widget>[
            NavigationDestination(
              label: 'Dashboard',
              tooltip: 'Dashboard',
              icon: Icon(
                AppAssets.kDashboardOutlied,
                size: 24,
                color: AppColors.kNeutral04,
              ),
              selectedIcon: Icon(
                AppAssets.kDashboard,
                size: 24,
                color: AppColors.kPrimary,
              ),
            ),
            NavigationDestination(
              label: 'Home',
              tooltip: 'Home',
              icon: Icon(
                AppAssets.kHomeOutlined,
                size: 24,
                color: AppColors.kNeutral04,
              ),
              selectedIcon: Icon(
                AppAssets.kHome,
                size: 24,
                color: AppColors.kPrimary,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                AppAssets.kPersionOutliend,
                size: 24,
                color: AppColors.kNeutral04,
              ),
              label: 'Profile',
              tooltip: 'Profile',
              selectedIcon: Icon(
                AppAssets.kPersion,
                size: 24,
                color: AppColors.kPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}