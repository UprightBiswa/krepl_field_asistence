import 'package:get/get.dart';

import '../../../controllers/master_controller.dart/doctor_controller.dart';
import '../model/doctor_list.dart';

class DoctorController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  List<Doctor> allDoctors = dummyDoctors;

  var filteredDoctors = <Doctor>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredDoctors.addAll(allDoctors); // Initialize with all Doctors
  }

  void filterDoctors(String query) {
    isLoading.value = true;
    filteredDoctors.value = allDoctors.where((Doctor) {
      final nameMatch =
          Doctor.name.toLowerCase().contains(query.toLowerCase());
      final mobileNumber =
          Doctor.mobileNumber.toLowerCase().contains(query.toLowerCase());
      return nameMatch || mobileNumber;
    }).toList();

    if (filteredDoctors.isEmpty) {
      errorMessage.value = 'No Doctors match your search.';
    } else {
      errorMessage.value = '';
    }

    isLoading.value = false;
  }

}
