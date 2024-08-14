import 'package:get/get.dart';

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

}
