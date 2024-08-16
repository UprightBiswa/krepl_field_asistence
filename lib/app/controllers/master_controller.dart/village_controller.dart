// controllers/Village_controller.dart
import 'package:get/get.dart';

import '../../model/master/villages_model.dart';

class VillageController extends GetxController {
  var villages = <Village>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadVillages();
    super.onInit();
  }

  Future<void> loadVillages() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      villages.assignAll(villagesList);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}
