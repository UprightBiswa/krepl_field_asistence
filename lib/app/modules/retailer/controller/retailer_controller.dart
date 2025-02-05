import 'dart:async';

import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../farmer/components/filter_bottom_sheet.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/success.dart';
import '../model/retailer_model_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RetailerController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var filteredRetailers = <Retailer>[].obs;

  final PagingController<int, Retailer> pagingController =
      PagingController(firstPageKey: 1);

  static const int pageSize = 10;
  var searchQuery = ''.obs;

  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();
  Timer? _debounce;
  final Set<String> _existingItemIds = <String>{};

  FilterController<String>? filterController;

  @override
  void onInit() {
    super.onInit();
    print("Retailer ListController initialized");

    filterController = FilterController<String>(
      filterOptions: [
        FilterOption(label: 'Retailer Name', value: 'retailer_name'),
        FilterOption(label: 'Mobile NO', value: 'mobile_no'),
        FilterOption(label: 'Village Name', value: 'village_name'),
      ],
      initialOrderBy: 'retailer_name',
    );

    pagingController.addPageRequestListener((pageKey) {
      print(
          "Page Request Listener Triggered: ${filterController!.selectedOrderBy.value}");
      fetchFarmers(pageKey, pagingController);
    });

    // Log and refresh items when filter changes
    filterController!.selectedOrderBy.listen((value) {
      print('Order By changed: $value');
      // refreshItems();
    });

    filterController!.order.listen((value) {
      print('Order changed: $value');
      // refreshItems();
    });
  }

  void fetchFarmers(
      int pageKey, PagingController<int, Retailer> pagingController) async {
    print("Fetching retailers for page: $pageKey");
    try {
      if (pageKey == 1) {
        isListLoading(true);
      }
      isListError(false);
      listErrorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }
      String endPoint = 'viewRetailer';
      Map<String, dynamic> parameters = {
        'page': pageKey,
        'limit': pageSize,
        'order': filterController!.order.value,
        'order_by': filterController!.selectedOrderBy.value,
        'filter_value': searchQuery.value,
      };

      final response = await _dioService.post(
        endPoint,
        queryParams: parameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final retailers = data.map((item) => Retailer.fromJson(item)).toList();
        // Filter out duplicates
        final List<Retailer> uniqueRetailers = retailers.where((farmer) {
          final isDuplicate = _existingItemIds.contains(farmer.id.toString());
          if (!isDuplicate) {
            _existingItemIds.add(farmer.id.toString());
          }
          return !isDuplicate;
        }).toList();

        final isLastPage = pageKey >= response.data['total_pages'];
        if (isLastPage) {
          pagingController.appendLastPage(uniqueRetailers);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(uniqueRetailers, nextPageKey);
        }
      } else {
        throw Exception('Failed to load retailers');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      pagingController.error = e;
      print('Error fetching retailers: $e');
    } finally {
      isListLoading(false);
    }
  }

  void setSearchQuery(String query) {
    print('Search Query: $query');
    searchQuery.value = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      refreshItems();
    });
  }

  void refreshItems() {
    print("Refreshing items...");
    _existingItemIds.clear();
    pagingController.refresh();
  }

  void clearFilters() {
    searchQuery.value = '';
    filterController!.selectedOrderBy.value = 'retailer_name';
    filterController!.order.value = 1;
    refreshItems();
  }

  @override
  void onClose() {
    pagingController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  // retailer create
  var isLoadingCreate = false.obs;
  var isErrorCreate = false.obs;
  var errorMessageCreate = ''.obs;

  Future<void> submitRetailerData(Map<String, dynamic> parameters) async {
    isLoadingCreate(true);
    isErrorCreate(false);
    errorMessageCreate('');
    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      final response =
          await _dioService.post('createRetailer', queryParams: parameters);

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
        throw Exception(response.data['message']);
      }
    } catch (e) {
      isErrorCreate(true);
      errorMessageCreate.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessageCreate.value,
              onClose: () {
                Get.back();
                Get.back();
              }),
          barrierDismissible: false);
      print('Error creating retailer: $e');
    } finally {
      isLoadingCreate(false);
    }
  }

  //fetch all retailer endpoint viewRetailer permeter form_value = all
  var isLoadingAllRetailer = false.obs;
  var isErrorAllRetailer = false.obs;
  var errorMessageAllRetailer = ''.obs;
  var allRetailer = <Retailer>[].obs;

  void fetchAllRetailers() async {
    try {
      isLoadingAllRetailer(true);
      isErrorAllRetailer(false);
      errorMessageAllRetailer.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      String endPoint = 'viewRetailer';
      Map<String, dynamic> parameters = {
        'form_value': 'all',
      };

      final response =
          await _dioService.post(endPoint, queryParams: parameters);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final retailers = data.map((item) => Retailer.fromJson(item)).toList();
        allRetailer.assignAll(retailers);
      } else {
        throw Exception('Failed to load retailers');
      }
    } catch (e) {
      isErrorAllRetailer(true);
      errorMessageAllRetailer.value = e.toString();
      print('Error fetching retailers: $e');
    } finally {
      isLoadingAllRetailer(false);
    }
  }
}
