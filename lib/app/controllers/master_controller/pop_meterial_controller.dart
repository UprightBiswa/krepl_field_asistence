import 'package:get/get.dart';

import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';

class PopMaterial {
  final int id;
  final String? code;
  final String? name;

  PopMaterial({
    required this.id,
    required this.code,
    required this.name,
  });
  factory PopMaterial.fromJson(Map<String, dynamic> json) {
    return PopMaterial(
      id: json['id'],
      code: json['code'] ?? "",
      name: json['pop_name'] ?? "",
    );
  }
}

class PopMaterialController extends GetxController {
  var popMeterial = <PopMaterial>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  void loadPopMeterial() async {
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
        'getPopMaterial',
      );

      if (response.data['success'] == true) {
        var popData = response.data['data'] as List;
        var popList =
            popData.map((json) => PopMaterial.fromJson(json)).toList();
        popMeterial.assignAll(popList);
      } else {
        isError(true);
        errorMessage('Failed to load PopMeterial');
      }
    } catch (e) {
      isError(true);
      errorMessage('Failed to load data');
    } finally {
      isLoading(false);
    }
  }
}
