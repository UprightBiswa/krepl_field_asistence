import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/helpers/utils/dioservice/dio_service.dart';
import 'dart:async';
import 'package:get/get.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../model/tour_list_model.dart';

class TourPlanController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  final scrollController = ScrollController();
  final List<TourPlan> tourPlanList = <TourPlan>[].obs;

  static const int pageSize = 10;
  var currentPage = 1;
  var isLastPage = false.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final TextEditingController textEditingController = TextEditingController();
  final searchQuery = ''.obs;
  final fromDate = Rxn<DateTime>();
  final toDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    fetchTourPlans();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !isLoadingMore.value &&
          !isLastPage.value) {
        loadMore();
      }
    });
  }

  Future<void> fetchTourPlans({bool refresh = false}) async {
    if (isLoading.value) return;
    if (refresh) {
      currentPage = 1;
      isLastPage.value = false;
      tourPlanList.clear();
    }

    isLoading.value = true;
    isError.value = false;
    errorMessage.value = '';

    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      Map<String, dynamic> parameters = {
        'page': currentPage,
        'limit': pageSize,
        'order_by': 'created_at',
        'order': -1,
        'filter_value': searchQuery.value,
        'from_date': fromDate.value != null
            ? DateFormat('yyyy-MM-dd').format(fromDate.value!)
            : null,
        'to_date': toDate.value != null
            ? DateFormat('yyyy-MM-dd').format(toDate.value!)
            : null,
      };

      final response = await _dioService.post(
        'viewFaTour',
        queryParams: parameters,
      );

      final data = response.data['data'] as List;
      final newPlans = data.map((e) => TourPlan.fromJson(e)).toList();

      if (newPlans.length < pageSize) {
        isLastPage.value = true;
      }

      tourPlanList.addAll(newPlans);
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() {
    if (isLastPage.value || isLoadingMore.value) return;

    isLoadingMore.value = true;
    currentPage += 1;
    fetchTourPlans().whenComplete(() => isLoadingMore.value = false);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    currentPage = 1;
    tourPlanList.clear();
    fetchTourPlans(refresh: true);
  }

  void setFromDate(DateTime date) {
    fromDate.value = date;
    if (toDate.value != null && fromDate.value!.isAfter(toDate.value!)) {
      toDate.value = fromDate.value;
    }
  }

  void setToDate(DateTime date) {
    if (fromDate.value != null && date.isBefore(fromDate.value!)) {
      return;
    }
    toDate.value = date;
  }

  void clearFilters() {
    searchQuery.value = '';
    textEditingController.clear();
    fromDate.value = null;
    toDate.value = null;
    currentPage = 1;
    tourPlanList.clear();
    fetchTourPlans(refresh: true);
  }

  void applyDateFilter() {
    currentPage = 1;
    tourPlanList.clear();
    fetchTourPlans(refresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
