// controllers/crop_controller.dart
import 'package:get/get.dart';

import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/crop_model.dart';

class CropController extends GetxController {
  var crops = <Crop>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  void loadCrops(List<int> seasonIds) async {
    print(seasonIds.length);
    isLoading(true);
    isError(false);
    errorMessage('');

    if (!await _connectivityService.checkInternet()) {
      isError(true);
      errorMessage('No internet connection');
      isLoading(false);
      return;
    }

    try {
      //preint each session id
      print(seasonIds);
      final response = await _dioService.post('getCrop', queryParams: {
        'season_id[]': seasonIds.map((id) => id.toString()).toList(),
      });

      if (response.data['success'] == true) {
        var cropData = response.data['data'] as List;
        var cropList = cropData.map((json) => Crop.fromJson(json)).toList();
        crops.assignAll(cropList);
      } else {
        isError(true);
        errorMessage('Failed to load crops');
      }
    } catch (e) {
      isError(true);
      errorMessage('Failed to load data');
    } finally {
      isLoading(false);
    }
  }
}
