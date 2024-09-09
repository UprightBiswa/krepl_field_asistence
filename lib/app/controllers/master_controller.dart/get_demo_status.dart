import 'package:get/get.dart';

import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/demo_status_model.dart';

class GetDomoStausController extends GetxController {
  var demoStatusData = <DemoStatus>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  void loadDemoStatusData() async {
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
      final response = await _dioService.post(
        'getDemoStatus',
      );

      if (response.data['success'] == true) {
        var demoStatusDataList = response.data['data'] as List;
        var demoStatusList = demoStatusDataList
            .map((json) => DemoStatus.fromJson(json))
            .toList();
        print(response.data);
        demoStatusData.assignAll(demoStatusList);
      } else {
        isError(true);
        errorMessage('Failed to load Demo Status Data');
      }
    } catch (e) {
      isError(true);
      errorMessage('Failed to load data');
    } finally {
      isLoading(false);
    }
  }
}
