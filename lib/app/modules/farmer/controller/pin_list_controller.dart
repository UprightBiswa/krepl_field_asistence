import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/pin_model.dart';

class PinController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var pinList = <PinModel>[].obs;

  // Fetch data
  Future<void> fetchPins() async {
    try {
      isLoading(true);
      isError(false);
      errorMessage('');

      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // API call
      final response = await _dioService.post(
        'getFaPin',
      );

      if (response.statusCode == 200) {
        bool success = response.data['success'] ?? false;
        if (success) {
          var data = response.data['data'] as List;
          pinList.value = data.map((e) => PinModel.fromMap(e)).toList();
        } else {
          throw Exception(response.data['message'] ?? 'Something went wrong');
        }
      } else {
        throw Exception(
            'Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
