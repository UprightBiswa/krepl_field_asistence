// controllers/doctor_controller.dart
import 'package:get/get.dart';

import '../../model/master/doctor_master_model.dart';

List<Doctor> dummyDoctors = [
  Doctor(
    name: "Dr. John Doe",
    fatherName: "Mr. Richard Doe",
    mobileNumber: "1234567890",
    acre: "5",
    pin: "123456",
    villageName: "Green Village",
    postOfficeName: "Green PO",
    subDistName: "Green Sub-Dist",
    districtName: "Green District",
    stateName: "Green State",
  ),
  Doctor(
    name: "Dr. Jane Smith",
    fatherName: "Mr. William Smith",
    mobileNumber: "0987654321",
    acre: "10",
    pin: "654321",
    villageName: "Blue Village",
    postOfficeName: "Blue PO",
    subDistName: "Blue Sub-Dist",
    districtName: "Blue District",
    stateName: "Blue State",
  ),
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
