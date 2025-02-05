import 'package:field_asistence/app/data/helpers/internet/connectivity_services.dart';
import 'package:field_asistence/app/data/helpers/utils/dioservice/dio_service.dart';
import 'package:get/get.dart';

import '../../../model/master/villages_model.dart';

class VillagePinController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var villages = <Village>[].obs;

  // Fetch villages based on pin code
  Future<void> fetchVillages(String pinCode) async {
    try {
      isLoading(true);
      isError(false);
      errorMessage('');
      villages.clear();

      // Check internet connection
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // API call
      final response = await _dioService.post(
        'getVillageByPin',
        queryParams: {
          
          'pin_code': pinCode,
        },
      );

      if (response.statusCode == 200) {
        bool success = response.data['success'] ?? false;
        if (success) {
          var data = response.data['data'] as List;
          villages.value = data.map((e) => Village.fromJson(e)).toList();
        } else {
          throw Exception(response.data['message'] ?? 'Something went wrong');
        }
      } else {
        throw Exception('Failed to fetch villages. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
