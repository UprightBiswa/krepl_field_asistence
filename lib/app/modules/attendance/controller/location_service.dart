import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  final Location _location = Location();
  RxString currentAddress = ''.obs;
  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;
  RxBool isServiceEnabled = true.obs;
  RxBool isPermissionGranted = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
    startLocationUpdates();
  }

  Future<void> checkPermissions() async {
    // Check if location service is enabled
    isServiceEnabled.value = await _location.serviceEnabled();
    if (!isServiceEnabled.value) {
      isServiceEnabled.value = await _location.requestService();
      if (!isServiceEnabled.value) {
        // Handle the case where location service is not enabled
        // Show a dialog or other user feedback mechanism
        // For example: Get.dialog(...)
        return;
      }
    }

    // Check and request location permission
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
      if (!status.isGranted) {
        isPermissionGranted.value = false;
        // Handle the case where permission is denied
        // Show a dialog or other user feedback mechanism
        // For example: Get.dialog(...)
        return;
      }
    }
    isPermissionGranted.value = true;
  }

  Future<void> startLocationUpdates() async {
    _location.onLocationChanged.listen((LocationData locationData) async {
      currentLatitude.value = locationData.latitude ?? 0.0;
      currentLongitude.value = locationData.longitude ?? 0.0;
      currentAddress.value = await _getAddress(locationData.latitude, locationData.longitude);
    });
  }

  Future<String> _getAddress(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      return 'Address not found';
    }
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.name}, ${placemark.locality}, ${placemark.country}';
      } else {
        return 'Address not found';
      }
    } catch (e) {
      return 'Address not found';
    }
  }
}
