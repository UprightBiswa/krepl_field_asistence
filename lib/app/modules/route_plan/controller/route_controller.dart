

import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/route_list.dart';

class RouteController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  List<RouteMap> allRouteMaps = dummyRouteData;

  var filteredRouteMaps = <RouteMap>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredRouteMaps.addAll(allRouteMaps); // Initialize with all RouteMaps
  }

  void filterRouteMaps(String query) {
    isLoading.value = true;
    filteredRouteMaps.value = allRouteMaps.where((routeMap) {
      final nameMatch =
          routeMap.routeName.toLowerCase().contains(query.toLowerCase());
      final mobileNumber =
          routeMap.routeNo.toLowerCase().contains(query.toLowerCase());
      return nameMatch || mobileNumber;
    }).toList();

    if (filteredRouteMaps.isEmpty) {
      errorMessage.value = 'No RouteMaps match your search.';
    } else {
      errorMessage.value = '';
    }

    isLoading.value = false;
  }

  // lode data from api fetchroutemasterdata
  var isLoadingList = true.obs;
  var errorMessageList = ''.obs;
  var isErrorList = false.obs;
  var routelist = <RouteMaster>[].obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  void fetchRouteMasterData() async {
    try {
      isLoadingList(true);
      isErrorList(false);
      errorMessageList('');

      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // API call
      final response = await _dioService.post('getRouteMaster');

      if (response.statusCode == 200) {
        bool success = response.data['success'] ?? false;
        if (success) {
          var data = response.data['data'] as List;
          var fetchedData =
              data.map((json) => RouteMaster.fromJson(json)).toList();
          print(response.data);
          routelist.assignAll(fetchedData);
        } else {
          String message = response.data['message'] ?? 'Unknown error occurred';
          errorMessageList(message);
          throw Exception(message);
        }
      } else {
        String error = 'Failed to load data: HTTP ${response.statusCode}';
        errorMessageList(error);
        throw Exception(error);
      }
    } catch (e) {
      errorMessageList(e.toString());
      isErrorList(true);
    } finally {
      isLoadingList(false);
    }
  }
}
