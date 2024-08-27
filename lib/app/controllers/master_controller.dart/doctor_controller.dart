// controllers/doctor_controller.dart
import 'package:get/get.dart';

import '../../modules/doctor/model/doctor_list.dart';

List<Doctor> dummyDoctors = [
  Doctor(
    name: "Dr. John Doe",
    fatherName: "Mr. Richard Doe",
    mobileNumber: "1234567890",
    acre: "5",
    pinCode: "110001",
    villageLocalityName: "Springfield",
    postOfficeName: "BO",
    subDistName: "Central",
    districtName: "Springfield District",
    stateName: "Springfield State",
    workPlaceCode: "WP001",
    workPlaceName: "Springfield Clinic",
  ),
  Doctor(
    name: "Dr. Jane Smith",
    fatherName: "Mr. William Smith",
    mobileNumber: "0987654321",
    acre: "10",
    pinCode: "220002",
    villageLocalityName: "Lakeside",
    postOfficeName: "SO",
    subDistName: "East",
    districtName: "Lakeside District",
    stateName: "Lakeside State",
    workPlaceCode: "WP002",
    workPlaceName: "Lakeside Hospital",
  ),
  Doctor(
    name: "Dr. Emily Clark",
    fatherName: "Mr. George Clark",
    mobileNumber: "1122334455",
    acre: "10",
    pinCode: "330003",
    villageLocalityName: "Greensville",
    postOfficeName: "HO",
    subDistName: "West",
    districtName: "Greensville District",
    stateName: "Greensville State",
    workPlaceCode: "WP003",
    workPlaceName: "Greensville Health Center",
  )
];

class DoctorController extends GetxController {
  var doctors = <Doctor>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadDoctors();
    super.onInit();
  }

  Future<void> loadDoctors() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      doctors.assignAll(dummyDoctors);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}
