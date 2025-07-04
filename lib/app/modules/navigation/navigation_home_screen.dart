
import 'package:flutter/material.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../custom_drawer/drawer_user_controller.dart';
import '../custom_drawer/home_drawer.dart';
import '../landing_screens/landing_page.dart';
import '../notification/notification_view.dart';
import 'help_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  final UserDetails userDetails;
  const NavigationHomeScreen({
    super.key,
    required this.userDetails,
  });

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = LandingPage(userDetails: widget.userDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: drawerIndex == DrawerIndex.HOME,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (drawerIndex != DrawerIndex.HOME) {
          setState(() {
            drawerIndex = DrawerIndex.HOME;
            screenView = LandingPage(userDetails: widget.userDetails);
          });
        } else {
          if (didPop) {
            print("App is closing from home page");
          }
        }
      },
      child: Container(
        color: AppColors.kWhite,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.kInput,
            body: DrawerUserController(
              userDetails: widget.userDetails,
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
              },
              screenView: screenView,
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = LandingPage(userDetails: widget.userDetails);
          });
          break;
        case DrawerIndex.Support:
          setState(() {
            screenView = const HelpScreen();
          });
          break;
        case DrawerIndex.Notification:
          setState(() {
            screenView = const NotificationView(
              showappbar: false,
            );
          });
          break;
        default:
          break;
      }
    }
  }

  
}
