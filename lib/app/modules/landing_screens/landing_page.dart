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
    Key? key,
    this.userDetails,
    this.pageIndex,
  }) : super(key: key);

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
    // List<PreferredSizeWidget> appBarList = [
    //   PreferredSize(
    //     preferredSize: const Size.fromHeight(kToolbarHeight),
    //     child: HomeAppBar(
    //       title: 'Dashboard',
    //       onLeadingPressed: () {
    //         scaffoldKey.currentState?.openDrawer();
    //       },
    //       userDetails: userDetails!,
    //     ),
    //   ),
    //   PreferredSize(
    //     preferredSize: const Size.fromHeight(kToolbarHeight),
    //     child: HomeAppBar(
    //       title: 'Home',
    //       onLeadingPressed: () {
    //         scaffoldKey.currentState?.openDrawer();
    //       },
    //       userDetails: userDetails!,
    //     ),
    //   ),
    //   // PreferredSize(
    //   //   preferredSize: const Size.fromHeight(kToolbarHeight),
    //   //   child: HomeAppBar(
    //   //     title: 'Products',
    //   //     onLeadingPressed: () {
    //   //       scaffoldKey.currentState?.openDrawer();
    //   //     },
    //   //     userDetails: userDetails!,
    //   //   ),
    //   // ),
    // ];
    // ignore: deprecated_member_use
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
        // appBar: appBarList[_currentIndex],
        //  body: _widgetOptions.elementAt(_currentIndex),
        body: _widgetOptions[_currentIndex],
        // drawer: CustomDrawer(
        //   userDetails: userDetails!,
        // ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
             BottomNavigationBarItem(
              label: 'Dashboard',
              tooltip: 'Dashboard',
              icon:   Icon(
                AppAssets.kDashboard,
                size: 24,
                 color: AppColors.kNeutral04,
              ),
               activeIcon: Icon(
                AppAssets.kDashboard,
                 size: 24,
                color: AppColors.kPrimary,
              ),
            ),
             BottomNavigationBarItem(
              label: 'Home',
              tooltip: 'Home',
               icon:   Icon(
                AppAssets.kHomeOutlined,
                size: 24,
                 color: AppColors.kNeutral04,
              ),
               activeIcon: Icon(
                AppAssets.kHome,
                 size: 24,
                color: AppColors.kPrimary,
              ),
            ),

            BottomNavigationBarItem(
                icon:  Icon( AppAssets.kPersionOutliend, 
                 size: 24,
                color: AppColors.kNeutral04,),
                label: 'Profile',
                tooltip: 'Profile',
                activeIcon:  Icon(
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
