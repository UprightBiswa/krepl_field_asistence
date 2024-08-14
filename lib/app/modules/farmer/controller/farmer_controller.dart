import 'package:get/get.dart';

import '../model/farmer_list.dart';

class FarmerController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  List<Farmer> allFarmers = farmersList;

  var filteredFarmers = <Farmer>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredFarmers.addAll(allFarmers); // Initialize with all farmers
  }

  void filterFarmers(String query) {
    isLoading.value = true;
    filteredFarmers.value = allFarmers.where((farmer) {
      final nameMatch =
          farmer.farmersName.toLowerCase().contains(query.toLowerCase());
      final mobileNumber =
          farmer.mobileNumber.toLowerCase().contains(query.toLowerCase());
      return nameMatch || mobileNumber;
    }).toList();

    if (filteredFarmers.isEmpty) {
      errorMessage.value = 'No farmers match your search.';
    } else {
      errorMessage.value = '';
    }

    isLoading.value = false;
  }

}
