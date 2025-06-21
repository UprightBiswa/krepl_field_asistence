import 'dart:io';

import 'package:field_asistence/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'app/data/constrants/constants.dart';
import 'app/modules/attendance/controller/loaction_service.dart';
import 'app/modules/splash_screens/splash_screens.dart';
import 'app/provider/common_provider.dart';
import 'app/repository/firebase/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(defaultOverlay);
  if (Platform.isAndroid) {
    final androidVersion =
        int.parse(Platform.version.split(' ').first.split('.').first);
    if (androidVersion >= 15) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
    }
  }
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await BackgroundService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        CommonProviders.connectionProvider(),
        CommonProviders.authStateProvider(),
        CommonProviders.loginProvider(),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 844),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: GetMaterialApp(
              title: 'KRISHAJ SAHAYAK',
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              defaultTransition: Transition.cupertino,
              theme: AppTheme.lightTheme,
              home: const SplashScreen(),
              builder: (context, child) {
                return SafeArea(
                  bottom: true,
                  top: false,
                  child: child ?? const SizedBox(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
