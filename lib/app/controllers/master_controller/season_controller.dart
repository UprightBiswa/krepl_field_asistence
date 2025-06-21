import 'package:get/get.dart';

import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/season_model.dart';

class SeasonController extends GetxController {
  var seasons = <Season>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    loadSeasons(); // Load seasons when the controller is initialized
    super.onInit();
  }

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  void loadSeasons() async {
    try {
      isLoading(true);
      isError(false);
      errorMessage('');

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      String endPoint = 'getSeason';
      final response = await _dioService.post(endPoint);

      if (response.statusCode == 200 && response.data['success'] == true) {
        var data = response.data['data'] as List;

        var fetchedSeasons = data.map((json) => Season.fromJson(json)).toList();
        seasons.assignAll(fetchedSeasons);
      } else {
        String message = response.data['message'] ?? 'Failed to load data';
        print('Error fetching data: $message');
        errorMessage(message);
        throw Exception(message);
      }
    } catch (e) {
      errorMessage(e.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
