// controllers/product_master_controller.dart
import 'package:get/get.dart';

import '../../model/master/product_master.dart';

List<ProductMaster> dummyProductMasters = [
  ProductMaster(brandCode: "Paushak", brandName: "Paushak", meterialName: 'Paushak', meterialCode: '000111'),
  ProductMaster(brandCode: "K Max", brandName: "K Max", meterialName: 'K Max', meterialCode: '000222'),
];

class ProductMasterController extends GetxController {
  var productMasters = <ProductMaster>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadProductMasters();
    super.onInit();
  }

  Future<void> loadProductMasters() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      productMasters.assignAll(dummyProductMasters);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}
