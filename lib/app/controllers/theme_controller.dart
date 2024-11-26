// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:ui' as ui;
// class ThemeController extends GetxController with WidgetsBindingObserver {
//   String theme = ThemeOptions.light;

//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);
//     getThemeState();
//   }

//   @override
//   void onClose() {
//     // Stop listening when the controller is disposed
//     WidgetsBinding.instance.removeObserver(this);
//     super.onClose();
//   }

//   @override
//   void didChangePlatformBrightness() {
//     var brightness = ui.PlatformDispatcher.instance.platformBrightness; 
//     if (brightness == Brightness.light) {
//       setTheme(ThemeOptions.light);
//     } else {
//       setTheme(ThemeOptions.dark);
//     }
//   }

//   Future<void> getThemeState() async {
//     var brightness = ui.PlatformDispatcher.instance.platformBrightness; 

//     // return setTheme(ThemeOptions.light);
//     if (brightness == Brightness.light) {
//       setTheme(ThemeOptions.light);
//     } else {
//       setTheme(ThemeOptions.dark);
//     }
//   }

//   Future<void> setTheme(String value) async {
//     theme = value;
//     if (value == ThemeOptions.light) Get.changeThemeMode(ThemeMode.light);
//     if (value == ThemeOptions.dark) Get.changeThemeMode(ThemeMode.dark);
//     update();
//   }
// }

// class ThemeOptions {
//   static String light = 'light';
//   static String dark = 'dark';
// }
