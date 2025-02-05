import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/tour_activity_type_model.dart';

class TourActivityController extends GetxController {
  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  // State variables
  final isLoading = false.obs;
  final error = ''.obs;
  final activities = <TourActivity>[].obs;

  // Fetch activities API function
  Future<void> fetchActivities() async {
    try {
      // Set loading state
      isLoading.value = true;
      error.value = '';

      // Check internet connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // API call
      final response = await _dioService.post(
        'getActivityForTour',
      );

      print(response.data);

      // Check response status and success
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Map response data to the Activity model
        activities.value = (response.data['data'] as List)
            .map((activity) => TourActivity.fromJson(activity))
            .toList();
      } else {
        throw Exception(response.data['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      // Handle errors
      error.value = e.toString();
    } finally {
      // Reset loading state
      isLoading.value = false;
    }
  }
}
