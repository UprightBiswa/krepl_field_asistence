import 'package:get/get.dart';
import '../../data/helpers/internet/connectivity_services.dart';
import '../../data/helpers/utils/dioservice/dio_service.dart';
import '../../model/master/product_master.dart';

class ProductMasterController extends GetxController {
  RxList<ProductMaster> productMasters = <ProductMaster>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void onInit() {
    super.onInit();
    loadProductMasters('000');
  }

  // Function to load product masters based on search query
  Future<void> loadProductMasters(String search) async {
    print(search);
    if (search.isEmpty) {
      error.value = '';
      productMasters.clear();
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      // Check internet connection
      if (!await _connectivityService.checkInternet()) {
        error('No internet connection');
        isLoading(false);
        return;
      }

      String endPoint = 'viewFaProducts';
      Map<String, dynamic> queryParams = {'search': search};

      final response =
          await _dioService.post(endPoint, queryParams: queryParams);

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          final List<dynamic> data = response.data['data'];
          if (data.isNotEmpty) {
            productMasters
                .assignAll(data.map((e) => ProductMaster.fromJson(e)));
          } else {
            productMasters.clear();
          }
        } else {
          productMasters.clear();
        }
      } else {
        productMasters.clear();
      }
    } catch (e) {
      productMasters.clear();
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
