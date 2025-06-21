import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/tour_route_master.dart';

class TourRouteController extends GetxController {
  // Reactive variables
  var isLoadingList = false.obs;
  var isErrorList = false.obs;
  var errorMessageList = ''.obs;
  var routeList = <TourRouteMaster>[].obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  // Fetch routes for selected villages
  Future<void> fetchRoutes(List<int> villageIds) async {
    try {
      print('Fetching routes for villages: $villageIds');
      // Show loading indicator
      isLoadingList.value = true;
      isErrorList.value = false;

      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Clear old route data
      routeList.clear();

      // API call
      final response = await _dioService.post(
        'getRouteForTour',
        queryParams: {
          'village_id[]': villageIds,
        },
      );

      if (response.data['success']) {
        final List<dynamic> data = response.data['data'] ?? [];
        routeList.value =
            data.map((route) => TourRouteMaster.fromMap(route)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch routes');
      }
    } catch (e) {
      // Handle error
      isErrorList.value = true;
      errorMessageList.value = e.toString();
    } finally {
      // Stop loading indicator
      isLoadingList.value = false;
    }
  }

  List<TourRouteMaster> getRoutesByIds(List<int> id) {
    return routeList.where((r) => id.contains(r.id)).toList();
  }
}
