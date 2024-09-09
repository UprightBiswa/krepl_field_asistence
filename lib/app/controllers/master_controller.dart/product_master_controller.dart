import 'package:get/get.dart';
import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/product_master.dart';

class ProductMasterController extends GetxController {
  var productMasters = <ProductMaster>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  // Inject services (replace with your actual services)
  final DioService _dioService =
      DioService(); // Assuming you have a DioService for API calls
  final ConnectivityService _connectivityService =
      ConnectivityService(); // Connectivity check

  @override
  void onInit() {
    super.onInit();
    loadProductMasters('000');
  }

  // Function to load product masters based on search query
  Future<void> loadProductMasters(String search) async {
    isLoading.value = true;
    error.value = '';

    try {
      // Check internet connection
      if (!await _connectivityService.checkInternet()) {
        error('No internet connection');
        isLoading(false);
        return;
      }

      // API endpoint and query parameters
      String endPoint = 'viewFaProducts';
      Map<String, dynamic> queryParams = {
        'search': search, // Pass search term
      };

      // Make API call
      final response =
          await _dioService.post(endPoint, queryParams: queryParams);

      // Check if response is successful
      if (response.statusCode == 200 && response.data['success'] == true) {
        var data = response.data['data'] as List;

        // Convert the response data into ProductMaster models
        productMasters.assignAll(
          data.map((json) => ProductMaster.fromJson(json)).toList(),
        );
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load products');
      }
    } catch (e) {
      // Handle exceptions and set error message
      error.value = e.toString();
    } finally {
      isLoading.value = false; // Always stop loading after try-catch
    }
  }
}
