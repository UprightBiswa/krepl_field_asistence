import 'package:field_asistence/app/data/constrants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimary,
      brightness: Brightness.light,
    ),
    primarySwatch: Colors.teal,
    primaryColor: AppColors.kPrimary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.kBackground,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: AppTypography.kBold24.copyWith(color: Colors.black),
      backgroundColor: AppColors.kWhite,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
      labelPadding: EdgeInsets.only(
        left: 10,
        right: AppSpacing.tenHorizontal,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: AppTypography.kBold20,
      labelColor: AppColors.kDarkContiner,
      unselectedLabelColor: AppColors.kLightBrown,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.twentyHorizontal,
        vertical: 16.h,
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.kPrimary,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    dataTableTheme: DataTableThemeData(
      headingRowColor: MaterialStateProperty.all(
        AppColors.kPrimary,
      ),
      dataTextStyle: const TextStyle(fontSize: 12, color: Colors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.kPrimary,
      brightness: Brightness.dark,
    ),
    // primarySwatch: Colors.teal,
    primaryColor: AppColors.kPrimary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.kDarkBackground,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
      backgroundColor: AppColors.kDarkSurfaceColor,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
      labelPadding: EdgeInsets.only(
        left: 10,
        right: AppSpacing.tenHorizontal,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: AppTypography.kBold20,
      labelColor: AppColors.kWhite,
      unselectedLabelColor: Colors.grey,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.twentyHorizontal,
        vertical: 16.h,
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      // backgroundColor: AppColors.kDarkSurfaceColor,
      backgroundColor: AppColors.kPrimary,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    dataTableTheme: DataTableThemeData(
      // headingRowColor: MaterialStateProperty.all(Colors.grey[300]),
      // dataTextStyle: TextStyle(fontSize: 12),
      //handel for dark theme
      headingRowColor: MaterialStateProperty.all(
        AppColors.kPrimary,
      ),
      dataTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
    ),
  );
}

// Default Overlay.
SystemUiOverlayStyle defaultOverlay = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.black,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
);

SystemUiOverlayStyle customOverlay = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);
