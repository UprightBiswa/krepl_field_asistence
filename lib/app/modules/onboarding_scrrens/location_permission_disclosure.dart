import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../attendance/controller/loaction_service.dart';
import '../navigation/navigation_home_screen.dart';
import '../auth/sign_in_page.dart';

class LocationPermissionDisclosure extends StatelessWidget {
  final bool isLoggedIn;
  final dynamic userDetails;

  const LocationPermissionDisclosure({
    super.key,
    required this.isLoggedIn,
    this.userDetails,
  });

  Future<void> _requestPermissionsAndContinue(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await _showPermissionSettingsDialog(context);
      return;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await BackgroundService.initialize();

      if (isLoggedIn && userDetails != null) {
        Get.offAll(() => NavigationHomeScreen(userDetails: userDetails));
      } else {
        Get.offAll(() => const SignIn());
      }
    } else {
      Get.snackbar(
          "Permission Denied", "Location permission is required to continue.");
    }
  }

  Future<void> _showPermissionSettingsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission Required"),
        content: const Text(
          "Location permission is permanently denied. Please enable it from app settings.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Permission")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Why We Need Your Location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Krishaj Sahayak collects location data to enable attendance and route tracking, "
              "even when the app is closed or not in use. This helps us ensure timely attendance logs "
              "and accurate route tracking for your activities.",
              style: TextStyle(fontSize: 15),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _requestPermissionsAndContinue(context),
                child: const Text("Allow and Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
