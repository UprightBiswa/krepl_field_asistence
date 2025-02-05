import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../activity/formA/form_a_manage_page.dart';
import '../../activity/formB/form_b_manage_page.dart';
import '../../activity/formC/form_c_manage_page.dart';
import '../../activity/formD/form_d_manage_page.dart';
import '../../activity/formE/form_e_manage_page.dart';
import '../../doctor/doctor_managment_page.dart';
import '../../expense/expense_manage_page.dart';
import '../../farmer/controller/farmer_controller.dart';
import '../../farmer/farmer_managment_page.dart';
import '../../report/activity/activity_report_page.dart';
import '../../report/activity_summery/activity_summery_report_page.dart';
import '../../report/customer/customer_report_page.dart';
import '../../report/demo/demo_report_page.dart';
import '../../retailer/retailer_managment_page.dart';
import '../../route_plan/route_managment_page.dart';
import '../../tour_plan/tour_plan_manage_page.dart';

class RandomColorGenerator {
  final Random _random = Random();
  Color generateColor() {
    // Generate random colors
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  // Generate a random gradient
  LinearGradient generateGradient() {
    return LinearGradient(colors: [
      generateColor().withOpacity(0.5),
      generateColor().withOpacity(0.5)
    ]);
  }

  // Return a gradient based on an index for consistent color mapping
  LinearGradient getGradientForIndex(
      int index, List<LinearGradient> predefinedGradients) {
    return predefinedGradients[index % predefinedGradients.length];
  }
}

final RandomColorGenerator colorGenerator = RandomColorGenerator();

class Heading {
  final String title;

  Heading({
    required this.title,
  });
}

class MenuGroup {
  final Heading heading;
  final List<MenuItem> menuItems;

  MenuGroup({
    required this.heading,
    required this.menuItems,
  });
}

class MenuItem {
  final String title;
  final IconData icon;
  final Function onTap;

  MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

final FarmerController _farmerController = Get.put(FarmerController());

List<MenuItem> reportMenuItems = [
  MenuItem(
    title: 'Farmer Registration',
    icon: Icons.agriculture, // Example icon
    onTap: () {
      Get.to<void>(
        () => const FarmerManagementPage(),
        transition: Transition.rightToLeftWithFade,
      )!
          .then((value) {
        _farmerController.fetchRecentFarmers();
      });
    },
  ),
  MenuItem(
    title: 'Doctor Registration',
    icon: Icons.local_hospital, // Example icon
    onTap: () {
      Get.to<void>(
        () => const DoctorManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Tour Plan Management',
    icon: Icons.map, // Example icon
    onTap: () {
      Get.to<void>(
        () => const TourPlanManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Activity Summary',
    icon: Icons.analytics,
    onTap: () {
      Get.to<void>(
        () => const ActivitySummaryPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Activity',
    icon: Icons.event, // Example icon
    onTap: () {
      Get.to<void>(
        () => const ActivityReportPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Customer',
    icon: Icons.person_pin, // Example icon
    onTap: () {
      Get.to<void>(
        () => const CustomerReportPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Retailer',
    icon: Icons.store, // Example icon
    onTap: () {
      Get.to(() => const RetailerManagementPage(),
              transition: Transition.rightToLeftWithFade)!
          .then((value) {
        _farmerController.fetchRecentFarmers();
      });
    },
  ),
  MenuItem(
    title: 'Route Plan',
    icon: Icons.route, // Example icon
    onTap: () {
      Get.to<void>(
        () => const RoutePlanManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Demo',
    icon: Icons.play_circle_fill, // Example icon
    onTap: () {
      // Handle navigation to Demo page DemoReportPage
      Get.to<void>(
        () => const DemoReportPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
];

List<MenuItem> formMenuItems = [
  MenuItem(
    title: 'Activity Management',
    icon: Icons.local_activity_outlined, // Example icon
    onTap: () {
      Get.to<void>(
        () => const FormAManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Jeep Campaign',
    icon: Icons.campaign_outlined, // Example icon
    onTap: () {
      //
      Get.to<void>(
        () => const FormBManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Dealer Stock',
    icon: Icons.inventory_rounded, // Example icon
    onTap: () {
      Get.to<void>(
        () => const FormCManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Demonstration Management',
    icon: Icons.preview_outlined, // Example icon
    onTap: () {
      Get.to<void>(
        () => const FormDManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'POP Management',
    icon: Icons.pages, // Example icon
    onTap: () {
      Get.to<void>(
        () => const FormEManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Farmer Management',
    icon: Icons.agriculture_rounded, // Example icon
    onTap: () {
      Get.to(() => const FarmerManagementPage(),
              transition: Transition.rightToLeftWithFade)!
          .then((value) {
        _farmerController.fetchRecentFarmers();
      });
    },
  ),
];

// Menu Items for the new group
List<MenuItem> shortcutMenuItems = [
  MenuItem(
    title: 'Farmer Management',
    icon: Icons.person_add,
    onTap: () {
      Get.to<void>(
        () => const FarmerManagementPage(),
        transition: Transition.rightToLeftWithFade,
      )!
          .then((value) {
        _farmerController.fetchRecentFarmers();
      });
    },
  ),
  MenuItem(
    title: 'Tour Plan Management',
    icon: Icons.map,
    onTap: () {
      // Handle navigation to Tour Plan page
      Get.to<void>(
        () => const TourPlanManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Expense Management',
    icon: Icons.currency_rupee_rounded,
    onTap: () {
      Get.to<void>(
        () => const ExpenseManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
];

// Creating menu groups with headings
MenuGroup reportMenuGroup = MenuGroup(
  heading: Heading(title: 'Reports Management'),
  menuItems: reportMenuItems,
);

MenuGroup activityFormGroup = MenuGroup(
  heading: Heading(title: 'Activity Forms'),
  menuItems: formMenuItems,
);

MenuGroup shortcutMenuGroup = MenuGroup(
  heading: Heading(title: 'Quick Actions'),
  menuItems: shortcutMenuItems,
);
