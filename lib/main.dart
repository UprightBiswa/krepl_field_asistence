import 'package:field_asistence/app/controllers/theme_controller.dart';
import 'package:field_asistence/app/data/helpers/theme_helper.dart';
import 'package:field_asistence/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'app/data/constrants/constants.dart';
import 'app/modules/splash_screens/splash_screens.dart';
import 'app/provider/common_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(defaultOverlay);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    debugPrint(themeController.theme);
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
              title: 'Field Asistence',
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              scrollBehavior: const ScrollBehavior()
                  .copyWith(physics: const BouncingScrollPhysics()),
              defaultTransition: Transition.fadeIn,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: getThemeMode(themeController.theme),
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
