import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import 'customer_model.dart';

class CustomerReportController extends GetxController {
  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  var customers = <Customer>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Pagination variables
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  var searchQuery = ''.obs;
  TextEditingController searchController = TextEditingController();

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchCustomerReport(); // Fetch initial data
  }

  Future<void> fetchCustomerReport({int page = 1}) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      // Check internet connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Fetch data with pagination
      final response = await _dioService.post(
        'faCustomerReport',
        queryParams: {
          'page': page,
          'limit': 10,
          'filter_value': searchQuery.value,
        },
      );

      if (response.statusCode == 200) {
        bool success = response.data['success'] ?? false;
        var data = response.data['data'] as List;
        if (success && data.isNotEmpty) {
          // var data = response.data['data'] as List;
          customers.value = data.map((e) => Customer.fromJson(e)).toList();

          // Update pagination info
          currentPage.value = response.data['page'] ?? 1;
          totalPages.value = response.data['total_pages'] ?? 1;
          // } else {
          //   hasError.value = true;
          //   errorMessage.value =
          //       response.data['message'] ?? 'Failed to load data.';
          // }
        } else {
          customers.clear();
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // hasError.value = true;
      // errorMessage.value = e.toString();
      if (e.toString().contains('Data Not Found')) {
        customers.clear(); // Show "No data available." instead of an error
      } else {
        hasError.value = true;
        errorMessage.value = e.toString();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchCustomerReport(page: 1);
    });
  }

  void loadNextPage() {
    if (currentPage.value < totalPages.value) {
      fetchCustomerReport(page: currentPage.value + 1);
    }
  }

  void loadPreviousPage() {
    if (currentPage.value > 1) {
      fetchCustomerReport(page: currentPage.value - 1);
    }
  }
}
