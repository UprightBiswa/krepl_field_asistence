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
      generateColor().withValues(alpha: .5),
      generateColor().withValues(alpha: .5)
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
    onTap: () async {
      await Get.to(
        () => const FarmerManagementPage(),
      );

      _farmerController.fetchRecentFarmers();
    },
  ),
  MenuItem(
    title: 'Doctor Registration',
    icon: Icons.local_hospital, // Example icon
    onTap: () async {
      await Get.to(
        () => const DoctorManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'Tour Plan Management',
    icon: Icons.map, // Example icon
    onTap: () {
      Get.to(
        () => const TourPlanManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'Activity Summary',
    icon: Icons.analytics,
    onTap: () async {
      await Get.to(
        () => const ActivitySummaryPage(),
      );
    },
  ),
  MenuItem(
    title: 'Activity',
    icon: Icons.event, // Example icon
    onTap: () async {
      await Get.to(
        () => const ActivityReportPage(),
      );
    },
  ),
  MenuItem(
    title: 'Customer',
    icon: Icons.person_pin, // Example icon
    onTap: () async {
      await Get.to(
        () => const CustomerReportPage(),
      );
    },
  ),
  MenuItem(
    title: 'Retailer',
    icon: Icons.store, // Example icon
    onTap: () async {
      await Get.to(
        () => const RetailerManagementPage(),
      );

      _farmerController.fetchRecentFarmers();
    },
  ),
  MenuItem(
    title: 'Route Plan',
    icon: Icons.route,
    onTap: () {
      Get.to(
        () => const RoutePlanManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'Demo',
    icon: Icons.play_circle_fill, // Example icon
    onTap: () {
      Get.to(
        () => const DemoReportPage(),
      );
    },
  ),
];

List<MenuItem> formMenuItems = [
  MenuItem(
    title: 'Activity Management',
    icon: Icons.local_activity_outlined, // Example icon
    onTap: () {
      Get.to(
        () => const FormAManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'Jeep Campaign',
    icon: Icons.campaign_outlined, // Example icon
    onTap: () {
      Get.to(
        () => const FormBManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'Dealer Stock',
    icon: Icons.inventory_rounded, // Example icon
    onTap: () {
      Get.to(
        () => const FormCManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'Demonstration Management',
    icon: Icons.preview_outlined, // Example icon
    onTap: () {
      Get.to(
        () => const FormDManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'POP Management',
    icon: Icons.pages, // Example icon
    onTap: () {
      Get.to(
        () => const FormEManagementPage(),
      );
    },
  ),
  MenuItem(
    title: 'Farmer Management',
    icon: Icons.agriculture_rounded, // Example icon
    onTap: () async {
      await Get.to(
        () => const FarmerManagementPage(),
      );
      _farmerController.fetchRecentFarmers();
    },
  ),
];

// Menu Items for the new group
List<MenuItem> shortcutMenuItems = [
  MenuItem(
    title: 'Farmer Management',
    icon: Icons.person_add,
    onTap: () async {
      await Get.to(
        () => const FarmerManagementPage(),
      );
      _farmerController.fetchRecentFarmers();
    },
  ),
  MenuItem(
    title: 'Tour Plan Management',
    icon: Icons.map,
    onTap: () {
      Get.to(
        (() => const TourPlanManagementPage()),
      );
    },
  ),
  MenuItem(
    title: 'Expense Management',
    icon: Icons.currency_rupee_rounded,
    onTap: () {
      Get.to(
        () => const ExpenseManagementPage(),
      );
    },
  ),
];

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
