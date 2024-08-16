// controllers/season_controller.dart
import 'package:get/get.dart';

import '../../model/master/season_model.dart';


List<Season> dummySeasons = [
  Season(code: 1, name: "Ravi"),
  Season(code: 2, name: "Kharif"),
];

class SeasonController extends GetxController {
  var seasons = <Season>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadSeasons();
    super.onInit();
  }

  Future<void> loadSeasons() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      seasons.assignAll(dummySeasons);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}
