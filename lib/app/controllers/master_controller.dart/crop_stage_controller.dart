// controllers/crop_stage_controller.dart
import 'package:get/get.dart';

import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/crop_stage.dart';



class CropStageController extends GetxController {
  var cropStages = <CropStage>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();


  

  void loadCropStages() async {
    try {
    isLoading.value = true;
    isError(false);
    errorMessage('');

    if(! await _connectivityService.checkInternet()) {
      errorMessage('No internet connection');
      isError(true);
      isLoading(false);
      return;
    }

    final response = await _dioService.post('getCropStage');
    if(response.statusCode == 200) {
      bool success = response.data['success'] ?? false;
      if(success) {
        var data = response.data['data'] as List;
        var fetchedData = data.map((json) => CropStage.fromJson(json)).toList();
        cropStages.assignAll(fetchedData);
      } else {
        String message = response.data['message'] ?? 'Unknown error occurred';
        errorMessage(message);
        isError(true);
      }
    } else {
      String error = 'Failed to load data: HTTP ${response.statusCode}';
      errorMessage(error);
      isError(true);
    }
    } catch(e) {
      errorMessage(e.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}