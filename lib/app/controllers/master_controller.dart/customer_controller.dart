// controllers/doctor_controller.dart
import 'package:get/get.dart';

import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/customer_model.dart';



class CustomerController extends GetxController {
  var customer = <Customer>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadcustomer();
    super.onInit();
  }

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<void> loadcustomer() async {
    try {
      isLoading(true);
      error('');

      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // API call
      final response = await _dioService.post('viewFaCustomers');

      if (response.statusCode == 200) {
        bool success = response.data['success'] ?? false;
        if (success) {
          var data = response.data['data'] as List;
          var fetchedData =
              data.map((json) => Customer.fromJson(json)).toList();

          customer.assignAll(fetchedData);
        } else {
          String message = response.data['message'] ?? 'Unknown error occurred';
          error(message);
          throw Exception(message);
        }
      } else {
        String error = 'Failed to load data: HTTP ${response.statusCode}';
        throw Exception(error);
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
