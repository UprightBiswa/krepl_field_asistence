// form_c_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/form_c_model.dart';

class FormCController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  final PagingController<int, FormC> pagingController =
      PagingController(firstPageKey: 1);
  static const int pageSize = 10;
  Timer? _debounce;
  final Set<int> _existingItemIds = <int>{};

  var searchQuery = ''.obs;
  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  var fromDate = Rxn<DateTime>(); // Nullable DateTime
  var toDate = Rxn<DateTime>(); // Nullable DateTime

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchFormCData(pageKey);
    });
  }

  Future<void> fetchFormCData(int pageKey) async {
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
        'viewFormC',
        queryParams: parameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final formCList = data.map((item) => FormC.fromJson(item)).toList();

        final List<FormC> uniqueFormCList = formCList.where((formC) {
          final isDuplicate = _existingItemIds.contains(formC.id);
          if (!isDuplicate) {
            _existingItemIds.add(formC.id);
          }
          return !isDuplicate;
        }).toList();

        final isLastPage = pageKey >= response.data['total_pages'];
        if (isLastPage) {
          pagingController.appendLastPage(uniqueFormCList);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(uniqueFormCList, nextPageKey);
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
