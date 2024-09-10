import 'package:flutter/material.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../custom_drawer/drawer_user_controller.dart';
import '../custom_drawer/home_drawer.dart';
import '../landing_screens/landing_page.dart';
import '../notification/notification_view.dart';
import 'help_screen.dart';
import 'invite_friend_screen.dart';

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
      onPopInvoked: (bool didPop) {
        print("$didPop");
        // Check if the current screen is not LandingPage
        if (drawerIndex != DrawerIndex.HOME) {
          // Navigate back to the LandingPage
          setState(() {
            drawerIndex = DrawerIndex.HOME;
            screenView = LandingPage(userDetails: widget.userDetails);
          });
        } else {
          if (didPop) {
            // Optionally log or handle didPop event here
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
                //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
              },
              screenView: screenView,
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
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
        case DrawerIndex.Help:
          setState(() {
            screenView = HelpScreen();
          });
          break;
        case DrawerIndex.Notification:
          setState(() {
            screenView = const NotificationView(
              showappbar: false,
            );
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        default:
          break;
      }
    }
  }
}
