import 'package:get/get.dart';

import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/result_model.dart';

class GetDomoResultController extends GetxController {
  var demoResultData = <DemoResult>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  void loaddemoResultData() async {
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
        'getResult',
      );

      if (response.data['success'] == true) {
        var demoStatusDataList = response.data['data'] as List;
        var demoResultList = demoStatusDataList
            .map((json) => DemoResult.fromJson(json))
            .toList();
        print(response.data);
        demoResultData.assignAll(demoResultList);
      } else {
        isError(true);
        errorMessage('Failed to load demo Result Data');
      }
    } catch (e) {
      isError(true);
      errorMessage('Failed to load data');
    } finally {
      isLoading(false);
    }
  }
}
