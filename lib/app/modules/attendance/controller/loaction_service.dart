import 'package:flutter_background/flutter_background.dart' as fg;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'dart:async';

import '../model/location_data_model.dart';
import 'database_helper.dart';

class BackgroundService {
  static bool _isInitialized = false;
  static bool _isTracking = false;

  static Future<void> initialize() async {
    if (!_isInitialized) {
      const androidConfig = fg.FlutterBackgroundAndroidConfig(
        notificationTitle: 'Location Tracking',
        notificationText: 'Running in background',
        notificationImportance: fg.AndroidNotificationImportance.Max,
        notificationIcon:
            fg.AndroidResource(name: 'background_icon', defType: 'drawable'),
      );

      await fg.FlutterBackground.initialize(androidConfig: androidConfig);
      _isInitialized = true;
    }
    await fg.FlutterBackground.enableBackgroundExecution();
  }

  static Future<void> startTracking() async {
    await initialize(); // Ensure initialization before starting tracking
    if (fg.FlutterBackground.isBackgroundExecutionEnabled) {
      _isTracking = true;
      await _startLocationTracking();
    }
  }

  static Future<void> stopTracking() async {
    if (_isInitialized && _isTracking) {
      _isTracking = false;
      await fg.FlutterBackground.disableBackgroundExecution();
    } else {
      throw Exception(
          'Tracking is not active or FlutterBackground plugin is not initialized.');
    }
  }

  static Future<void> _startLocationTracking() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, notify the user
      throw const LocationServiceDisabledException();
    }
    // Request location permissions
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      throw Exception('Location permissions are permanently denied.');
    }

    const locationUpdateInterval = Duration(seconds: 1);
    Timer.periodic(locationUpdateInterval, (timer) async {
      if (!_isTracking) {
        timer.cancel(); // Stop the timer if tracking is disabled
        return;
      }

      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        print(
          DateTime.now(),
        );
        final now = DateTime.now();
        String date = DateFormat('yyyy-MM-dd').format(now);
        String time = DateFormat('hh:mm:ss a').format(now);
        final locationData = LocationDataModel(
          id: DateTime.now().millisecondsSinceEpoch,
          latitude: position.latitude,
          longitude: position.longitude,
          date: date,
          time: time,
        );

        // Save location data to the database
        final dbHelper = DatabaseHelper();
        await dbHelper.addLocation(locationData);
      } catch (e) {
        // Handle other possible exceptions, such as network issues
        print('Error getting location: $e');
      }
    });
  }
}
