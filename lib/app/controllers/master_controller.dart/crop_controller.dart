// controllers/crop_controller.dart
import 'package:get/get.dart';

import '../../model/master/crop_model.dart';

List<Crop> dummyCrops = [
  Crop(code: 1, name: "Wheat"),
  Crop(code: 2, name: "Paddy"),
];

class CropController extends GetxController {
  var crops = <Crop>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadCrops();
    super.onInit();
  }

  Future<void> loadCrops() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      crops.assignAll(dummyCrops);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}
