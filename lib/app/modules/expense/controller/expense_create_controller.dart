import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/expense_type_model.dart';

class ExpenseCreateController extends GetxController {
  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  // API Endpoint
  final String _endpoint = "createFaExpense";

  // Generate dynamic financial year list
  List<String> getFinancialYears() {
    final currentYear = DateTime.now().year;
    return List.generate(5, (index) {
      final startYear = currentYear + index;
      return "$startYear-${startYear + 1}";
    });
  }

  // Submit the form
  Future<void> submitForm({
    required String workplaceCode,
    required String workplaceName,
    required String hrEmployeeCode,
    required String employeeName,
    required List<MapEntry<String, String>> fields,
  }) async {
    isLoading.value = true;

    try {
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }
      // Prepare form data
      dio.FormData formData = dio.FormData();

      // Add single fields
      formData.fields.addAll([
        MapEntry('workplace_code', workplaceCode),
        MapEntry('workplace_name', workplaceName),
        MapEntry('hr_employee_code', hrEmployeeCode),
        MapEntry('employee_name', employeeName),
      ]);

      // Add array/list fields using the MapEntry list `fields`
      formData.fields.addAll(fields);

      // Make the API call
      final response = await _dioService.postFormData(_endpoint, formData);

      // Handle the response
      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', 'Expense submitted successfully.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        // Handle server-side errors
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

// ExpenseItem model
class ExpenseItem {
  ExpenseType? expenseType;
  TextEditingController monthController = TextEditingController();
  TextEditingController financialYearController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // Dispose controllers to prevent memory leaks
  void disposeControllers() {
    monthController.dispose();
    financialYearController.dispose();
    amountController.dispose();
  }
}
