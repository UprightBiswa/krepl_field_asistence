import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../activity/formA/form_a_manage_page.dart';
import '../../activity/formB/form_b_manage_page.dart';
import '../../activity/formC/form_c_manage_page.dart';
import '../../activity/formD/form_d_manage_page.dart';
import '../../activity/formE/form_e_manage_page.dart';
import '../../doctor/doctor_managment_page.dart';
import '../../farmer/controller/farmer_controller.dart';
import '../../farmer/farmer_managment_page.dart';
import '../../retailer/retailer_managment_page.dart';
import '../../route_plan/route_managment_page.dart';

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
        () => RoutePlanManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Activity Summary',
    icon: Icons.analytics,
    onTap: () {
      // Handle navigation to Activity Summary page
    },
  ),
  MenuItem(
    title: 'Activity',
    icon: Icons.event, // Example icon
    onTap: () {
      // Handle navigation to Activity page
    },
  ),
  MenuItem(
    title: 'Customer',
    icon: Icons.person_pin, // Example icon
    onTap: () {
      // Handle navigation to Retailer page
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
        () => RoutePlanManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Demo',
    icon: Icons.play_circle_fill, // Example icon
    onTap: () {
      // Handle navigation to Demo page
    },
  ),
];

List<MenuItem> formMenuItems = [
  MenuItem(
    title: 'Activity Management',
    icon: Icons.document_scanner, // Example icon
    onTap: () {
      Get.to<void>(
        () => FormAManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Jeep Campaign',
    icon: Icons.document_scanner, // Example icon
    onTap: () {
      //
      Get.to<void>(
        () => FormBManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Dealer Stock',
    icon: Icons.document_scanner, // Example icon
    onTap: () {
      Get.to<void>(
        () => FormCManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Demonstration Management',
    icon: Icons.document_scanner, // Example icon
    onTap: () {
      Get.to<void>(
        () => FormDManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'POP Management',
    icon: Icons.document_scanner, // Example icon
    onTap: () {
      Get.to<void>(
        () => FormEManagementPage(),
        transition: Transition.rightToLeftWithFade,
      );
    },
  ),
  MenuItem(
    title: 'Farmer Management',
    icon: Icons.document_scanner, // Example icon
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
      ;
    },
  ),
  MenuItem(
    title: 'Tour Plan Management',
    icon: Icons.map,
    onTap: () {
      // Handle navigation to Tour Plan page
    },
  ),
  MenuItem(
    title: 'Expense Management',
    icon: Icons.attach_money,
    onTap: () {
      // Handle navigation to Expense page
    },
  ),
];

// Creating menu groups with headings
MenuGroup reportMenuGroup = MenuGroup(
  heading: Heading(title: 'Reports'),
  menuItems: reportMenuItems,
);

MenuGroup activityFormGroup = MenuGroup(
  heading: Heading(title: 'Activity Forms'),
  menuItems: formMenuItems,
);

MenuGroup shortcutMenuGroup = MenuGroup(
  heading: Heading(title: 'Shortcuts'),
  menuItems: shortcutMenuItems,
);
