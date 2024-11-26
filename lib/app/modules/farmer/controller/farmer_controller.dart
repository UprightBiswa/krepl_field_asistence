import 'dart:async';

import 'package:get/get.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/success.dart';
import '../model/farmer_list.dart';

class FarmerController extends GetxController {
  //for create farmer
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  // for list of recent farmers
  var isLoadingrecent = true.obs;
  var isErrorrecent = false.obs;
  var errorMessageRecent = ''.obs;
  var recentFarmers = <Farmer>[].obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  void fetchRecentFarmers() async {
    try {
      isLoadingrecent(true);
      isErrorrecent(false);
      errorMessageRecent.value = '';

      if (!await _connectivityService.checkInternet()) {
        // errorMessage('No internet connection');
        throw Exception('No internet connection');
      }

      // Example endpoint and parameters
      String endPoint = 'viewFarmer';
      Map<String, dynamic> parameters = {
        'page': 1,
        'limit': 5,
        'order': -1,
        'order_by': 'village_name',
      };

      // Replace 'yourApiEndpoint' with the actual endpoint for fetching farmers
      final response =
          await _dioService.post(endPoint, queryParams: parameters);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final farmers = data.map((item) => Farmer.fromJson(item)).toList();
        recentFarmers.assignAll(farmers);
      } else {
        throw Exception('Failed to load recent farmers');
      }
    } catch (e) {
      isErrorrecent(true);
      errorMessageRecent.value = e.toString();
      print('Error fetching recent farmers: $e');
    } finally {
      isLoadingrecent(false);
    }
  }

  //create from
  Future<void> submitFarmerData(Map<String, dynamic> parameters) async {
    isLoading(true);
    isError(false);
    errorMessage('');

    try {
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint
      String endPoint = 'createFarmer';

      // API call
      final response =
          await _dioService.post(endPoint, queryParams: parameters);

      // Handle response
      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', response.data['message'],
            snackPosition: SnackPosition.BOTTOM);
        Get.dialog(
            SuccessDialog(
                message: response.data['message'],
                onClose: () {
                  Get.back();
                  Get.back();
                  Get.back();
                }),
            barrierDismissible: false);
      } else {
        // Handle error in response
        throw Exception(response.data['message']);
      }
    } catch (e) {
      // Handle exception
      isError(true);
      errorMessage(e.toString());
      Get.snackbar('Error', errorMessage.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessage.value,
              onClose: () {
                Get.back();
                Get.back();
              }),
          barrierDismissible: false);
    } finally {
      isLoading(false);
    }
  }

  //delete the farmer
  var isLoadingDelete = false.obs;
  var isErrorDelete = false.obs;
  var errorMessageDelete = ''.obs;

  Future<void> deleteFarmer(int farmerId) async {
    isLoadingDelete(true);
    isErrorDelete(false);
    errorMessageDelete('');

    try {
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint
      String endPoint = 'deleteFarmer';

      // API call
      final response = await _dioService.post(endPoint, queryParams: {
        'farmer_id': farmerId,
      });

      // Handle response
      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', response.data['message'],
            snackPosition: SnackPosition.BOTTOM);
        Get.dialog(
            SuccessDialog(
                message: response.data['message'],
                onClose: () {
                  Get.back();
                  Get.back();
                }),
            barrierDismissible: false);
      } else {
        // Handle error in response
        throw Exception(response.data['message']);
      }
    } catch (e) {
      // Handle exception
      isErrorDelete(true);
      errorMessageDelete(e.toString());
      Get.snackbar('Error', errorMessageDelete.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessageDelete.value,
              onClose: () {
                Get.back();
              }),
          barrierDismissible: false);
    } finally {
      isLoadingDelete(false);
    }
  }

  //EDIT FARMER
  var isLoadingEdit = false.obs;
  var isErrorEdit = false.obs;
  var errorMessageEdit = ''.obs;
  // editFarmer END PONT
  // Map<String, dynamic> parameters

  Future<void> editFarmer(Map<String, dynamic> parameters) async {
    isLoadingEdit(true);
    isErrorEdit(false);
    errorMessageEdit('');

    try {
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint
      String endPoint = 'editFarmer';

      // API call
      final response =
          await _dioService.post(endPoint, queryParams: parameters);
      print(response.data);

      // Handle response
      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', response.data['message'],
            snackPosition: SnackPosition.BOTTOM);
        Get.dialog(
            SuccessDialog(
                message: response.data['message'],
                onClose: () {
                  Get.back();
                  Get.back();
                  Get.back();
                }),
            barrierDismissible: false);
      } else {
        // Handle error in response
        throw Exception(response.data['message']);
      }
    } catch (e) {
      // Handle exception
      isErrorEdit(true);
      errorMessageEdit(e.toString());
      Get.snackbar('Error', errorMessageEdit.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessageEdit.value,
              onClose: () {
                Get.back();
                Get.back();
              }),
          barrierDismissible: false);
    } finally {
      isLoadingEdit(false);
    }
  }
}
