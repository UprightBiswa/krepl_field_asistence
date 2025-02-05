import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/helpers/utils/dioservice/dio_service.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../model/expense_list_model.dart';

class ExpenseController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  final PagingController<int, Expense> pagingController =
      PagingController(firstPageKey: 1);
  static const int pageSize = 10;
  Timer? _debounce;
  final Set<int> _existingItemIds = <int>{};
  final TextEditingController textController = TextEditingController();

  var searchQuery = ''.obs;
  var fromDate = Rxn<DateTime>(); // Nullable DateTime
  var toDate = Rxn<DateTime>();
  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchExpenses(pageKey);
    });
  }

  Future<void> fetchExpenses(int pageKey) async {
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
        'order_by': 'created_at',
        'filter_value': searchQuery.value,
        'from_date': fromDate.value != null
            ? DateFormat('yyyy-MM-dd').format(fromDate.value!)
            : null,
        'to_date': toDate.value != null
            ? DateFormat('yyyy-MM-dd').format(toDate.value!)
            : null,
      };

      final response = await _dioService.post(
        'viewFaExpense',
        queryParams: parameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final expenseList = data.map((item) => Expense.fromJson(item)).toList();

        final List<Expense> uniqueExpenseList = expenseList.where((expense) {
          final isDuplicate = _existingItemIds.contains(expense.id);
          if (!isDuplicate) {
            _existingItemIds.add(expense.id);
          }
          return !isDuplicate;
        }).toList();

        final isLastPage = pageKey >= response.data['total_pages'];
        if (isLastPage) {
          pagingController.appendLastPage(uniqueExpenseList);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(uniqueExpenseList, nextPageKey);
        }
      } else {
        listErrorMessage.value = "Failed to load data";
        pagingController.error = listErrorMessage.value;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      pagingController.error = e;
    } finally {
      isListLoading(false);
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

  void clearFilters() {
    print("From Date: ${fromDate.value}");
    print("To Date: ${toDate.value}");
    fromDate.value = null;
    toDate.value = null;
    searchQuery.value = '';
    textController.clear();
    _existingItemIds.clear();
    pagingController.refresh();
  }

  void applyDateFilter() {
    if (fromDate.value != null || toDate.value != null) {
      print("From Date: ${fromDate.value}");
      print("To Date: ${toDate.value}");
      _existingItemIds.clear();
      pagingController.refresh();
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    _debounce?.cancel();
    super.onClose();
  }
}
