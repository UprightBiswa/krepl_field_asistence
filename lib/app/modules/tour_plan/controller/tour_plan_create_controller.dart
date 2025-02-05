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
  Future<void> submitTourPlan(TourItem tourItem) async {
    isLoading.value = true;

    try {
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }
      // Prepare form data
      dio.FormData formData = dio.FormData();
      final formattedDate = DateFormat('yyyy-MM-dd').format(
          DateFormat('dd-MMM-yyyy').parse(tourItem.tourDateController.text));
      formData.fields.add(MapEntry("tour_date", formattedDate));

      // Add remarks
      formData.fields.add(MapEntry("remarks", tourItem.remarksController.text));

      // Add villages
      for (var village in tourItem.selectedVillages) {
        formData.fields.add(MapEntry("village[]", village.id.toString()));
      }

      // Add routes
      for (var route in tourItem.selectedRoutes) {
        formData.fields.add(MapEntry("route[]", route.id.toString()));
      }

      // Add activities
      for (var activity in tourItem.selectedActivities) {
        formData.fields.add(MapEntry("activity[]", activity.id.toString()));
      }

      // Make the API call
      final response = await _dioService.postFormData(_endpoint, formData);

      // Handle the response
      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', 'Tour plan submitted successfully.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception(response.data['message'] ?? 'Submission failed.');
      }
    } catch (e) {
      // Exception handling
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
