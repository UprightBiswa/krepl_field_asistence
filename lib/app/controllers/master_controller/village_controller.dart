import 'package:get/get.dart';
import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/villages_model.dart';

class VillageController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var villages = <Village>[].obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<void> fetchVillageMasterData() async {
    try {
      isLoading(true);
      isError(false);
      errorMessage('');

      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // API call
      final response = await _dioService.post('getVillage');

      if (response.statusCode == 200) {
        bool success = response.data['success'] ?? false;
        if (success) {
          var data = response.data['data'] as List;
          var fetchedData = data.map((json) => Village.fromMap(json)).toList();
          print(response.data);
          villages.assignAll(fetchedData);
        } else {
          String message = response.data['message'] ?? 'Unknown error occurred';
          errorMessage(message);
          throw Exception(message);
        }
      } else {
        String error = 'Failed to load data: HTTP ${response.statusCode}';
        errorMessage(error);
        throw Exception(error);
      }
    } catch (e) {
      errorMessage(e.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  List<Village> getVillagesByIds(List<int> id) {
    print('getVillagesByIds: $id');
    return villages.where((v) => id.contains(v.id)).toList();
  }
}
