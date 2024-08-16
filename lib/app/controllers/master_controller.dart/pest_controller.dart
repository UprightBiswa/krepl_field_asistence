// controllers/pest_controller.dart
import 'package:get/get.dart';

import '../../model/master/pest_master.dart';

class PestController extends GetxController {
  var pests = <Pest>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadPests();
    super.onInit();
  }

  Future<void> loadPests() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      pests.assignAll(dummyPests);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}

List<Pest> dummyPests = [
  Pest(code: 1, pest: "A"),
  Pest(code: 2, pest: "B"),
];
