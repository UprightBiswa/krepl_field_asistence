import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../../model/master/villages_model.dart';
import '../model/tour_activity_type_model.dart';
import '../model/tour_route_master.dart';

class TourPlanCreateController extends GetxController {
  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  // API Endpoint
  final String _endpoint = "createFaTourPlan";

  // Submit the form
  Future<bool> submitTourPlan(TourItem tourItem) async {
    isLoading.value = true;

    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      final formattedDate = DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MMM-yyyy').parse(tourItem.tourDateController.text));

      final dio.FormData formData = dio.FormData();

      formData.fields.add(MapEntry("tour_date", formattedDate));
      formData.fields.add(MapEntry("remarks", tourItem.remarksController.text));

      for (var village in tourItem.selectedVillages) {
        formData.fields.add(MapEntry("village[]", village.id.toString()));
      }
      for (var route in tourItem.selectedRoutes) {
        formData.fields.add(MapEntry("route[]", route.id.toString()));
      }
      for (var activity in tourItem.selectedActivities) {
        formData.fields.add(MapEntry("activity[]", activity.id.toString()));
      }

      final response = await _dioService.postFormData(_endpoint, formData);
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200 &&
          response.data['success'].toString() == 'true') {
        return true; // ✅ Success
      } else {
        throw Exception(response.data['message'] ?? 'Submission failed.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false; // ❌ Failure
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editTourPlan(TourItem tourItem, int tourId) async {
    isLoading.value = true;

    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      final formattedDate = DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MMM-yyyy').parse(tourItem.tourDateController.text));

      final dio.FormData formData = dio.FormData.fromMap({
        "tour_id": tourId.toString(),
        "tour_date": formattedDate,
        "remarks": tourItem.remarksController.text,
        "village[]":
            tourItem.selectedVillages.map((e) => e.id.toString()).toList(),
        "route[]": tourItem.selectedRoutes.map((e) => e.id.toString()).toList(),
        "activity[]":
            tourItem.selectedActivities.map((e) => e.id.toString()).toList(),
      });

      final response = await _dioService.postFormData(
        "updateFaTourPlan", // ✅ Edit endpoint
        formData,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', 'Tour plan updated successfully.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception(response.data['message'] ?? 'Update failed.');
      }
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}

class TourItem {
  List<Village> selectedVillages = [];
  List<TourRouteMaster> selectedRoutes = [];
  List<TourActivity> selectedActivities = [];
  TextEditingController tourDateController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  // Dispose controllers to prevent memory leaks
  void disposeControllers() {
    tourDateController.dispose();
    remarksController.dispose();
  }
}
