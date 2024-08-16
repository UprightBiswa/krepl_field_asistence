// controllers/crop_stage_controller.dart
import 'package:get/get.dart';

import '../../model/master/crop_stage.dart';

List<CropStage> dummyCropStages = [
  CropStage(code: 1, name: "0-15 Days"),
  CropStage(code: 2, name: "16-30 Days"),
  CropStage(code: 3, name: "31-45 Days"),
  CropStage(code: 4, name: "46-60 Days"),
  CropStage(code: 5, name: "61-75 Days"),
  CropStage(code: 6, name: "76-90 Days"),
  CropStage(code: 7, name: "91-105 Days"),
  CropStage(code: 8, name: "106-120 Days"),
  CropStage(code: 9, name: "121-135 Days"),
  CropStage(code: 10, name: "136-150 Days"),
];

class CropStageController extends GetxController {
  var cropStages = <CropStage>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadCropStages();
    super.onInit();
  }

  Future<void> loadCropStages() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      cropStages.assignAll(dummyCropStages);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}
