import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/location_data_model.dart';
import 'database_helper.dart';
import 'loaction_service.dart';

class LocationServiceController extends GetxController {
  RxBool isTracking = false.obs;
  RxList<LocationDataModel> locations = <LocationDataModel>[].obs;
  late SharedPreferences _prefs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
    _loadLocations(); // Load existing locations when initializing
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    isTracking.value = _prefs.getBool('isTracking') ?? false;
    if (isTracking.value) {
      BackgroundService.startTracking();
    }
  }

  Future<void> startService() async {
    isTracking.value = true;
    _prefs.setBool('isTracking', true);
    await BackgroundService.startTracking();
  }

  Future<void> stopService() async {
    isTracking.value = false;
    _prefs.setBool('isTracking', false);
    await BackgroundService.stopTracking();
  }

  Future<void> _loadLocations() async {
    final fetchedLocations = await _dbHelper.getAllLocations();
    locations.assignAll(fetchedLocations);
  }

  Future<void> clearLocationData() async {
    await _dbHelper.clearLocations();
    locations.clear(); // Clear the observable list
  }

  Future<void> refreshLocations() async {
    await _loadLocations(); // Refresh the list
  }
}
