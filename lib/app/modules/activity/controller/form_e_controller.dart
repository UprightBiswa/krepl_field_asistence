import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/form_e_model.dart';

class FormEController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  late final PagingController<int, FormE> pagingController;

  static const int pageSize = 10;
  Timer? _debounce;
  final Set<int> _existingItemIds = <int>{};

  var searchQuery = ''.obs;
  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  //delete loading
  var isDeleteLoading = false.obs;
  var isDeleteError = false.obs;
  var deleteErrorMessage = ''.obs;

  var fromDate = Rxn<DateTime>(); // Nullable DateTime
  var toDate = Rxn<DateTime>(); // Nullable DateTime

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController<int, FormE>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) => fetchFormEData(pageKey),
    );
  }

  Future<List<FormE>> fetchFormEData(int pageKey) async {
    try {
      if (pageKey == 1) {
        isListLoading(true);
      }
      isListError(false);
      listErrorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      Map<String, dynamic> parameters = {
        'page': pageKey,
        'limit': pageSize,
        'order': -1,
        'order_by': '',
        'filter_value': searchQuery.value,
        'form_value': 'all',
        'from_date': fromDate.value != null
            ? DateFormat('yyyy-MM-dd').format(fromDate.value!)
            : null,
        'to_date': toDate.value != null
            ? DateFormat('yyyy-MM-dd').format(toDate.value!)
            : null,
      };

      final response = await _dioService.post(
        'viewFormE',
        queryParams: parameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final formEList = data.map((item) => FormE.fromJson(item)).toList();

        final List<FormE> uniqueFormEList = formEList.where((formE) {
          final isDuplicate = _existingItemIds.contains(formE.id);
          if (!isDuplicate) {
            _existingItemIds.add(formE.id);
          }
          return !isDuplicate;
        }).toList();

        return uniqueFormEList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      rethrow;
    } finally {
      isListLoading(false);
    }
  }

  //deltefromE
  Future<void> deleteFormE(int formEId) async {
    try {
      isDeleteLoading(true);
      isDeleteError(false);
      deleteErrorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      final response = await _dioService.post(
        'deleteFormE',
        queryParams: {'form_e_id': formEId},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: response.data['message'] ?? 'Deleted successfully',
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        refreshItems();
      } else {
        throw Exception(response.data['message'] ?? 'Delete failed');
      }
    } catch (e) {
      isDeleteError(true);
      deleteErrorMessage.value = e.toString();
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isDeleteLoading(false);
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _existingItemIds.clear();
      pagingController.refresh();
    });
  }

  void refreshItems() {
    _existingItemIds.clear();
    pagingController.refresh();
  }

  void setFromDate(DateTime date) {
    fromDate.value = date;
    if (toDate.value != null && fromDate.value!.isAfter(toDate.value!)) {
      toDate.value = fromDate.value; // Adjust toDate if invalid
    }
  }

  void setToDate(DateTime date) {
    if (fromDate.value != null && date.isBefore(fromDate.value!)) {
      return; // Prevent invalid date selection
    }
    toDate.value = date;
  }

  void applyDateFilter() {
    if (fromDate.value != null || toDate.value != null) {
      print("From Date: ${fromDate.value}");
      print("To Date: ${toDate.value}");
      _existingItemIds.clear();
      pagingController.refresh();
    }
  }

  void clearFilters() {
    print("From Date: ${fromDate.value}");
    print("To Date: ${toDate.value}");
    fromDate.value = null;
    toDate.value = null;
    _existingItemIds.clear();
    pagingController.refresh();
  }

  @override
  void onClose() {
    pagingController.dispose();
    _debounce?.cancel();
    super.onClose();
  }
}
